module TotalCompressor
  class BaseCompressor
    PROJECT = Dir.pwd
    TEXT_FILE = 'test/text_file.txt'
    FILE = "#{PROJECT}/#{TEXT_FILE}"

    HOME = Dir.home
    TEST = "tmp_#{Time.now.to_i}"

    TEST_FILE = "#{HOME}/#{TEST}/#{TEXT_FILE.split('/').last}"
    TEMP_FOLDER = "#{HOME}/#{TEST}/"
    TEST_FOLDER = "#{HOME}/#{TEST}/#{TEST}"
    TEST_FOLDER_UNCOMPRESSED = "#{HOME}/#{TEST}/UNCOMPRESSED"

    HASH_TYPE = {
      'z' => 'zip',
      'r' => 'rar',
      '7' => '7z',
      'g' => 'gzip'
    }

    TYPE = {
      'zip' => {
        'tool'            => 'zip',
        'compress_file'   => '-9',
        'compress_folder' => '-9r',
        'success_message' => 'deflated'
      },
      'rar' => {
        'tool'            => 'rar',
        'compress_file'   => 'a',
        'compress_folder' => 'a',
        'decompress'      => 'x',
        'success_message' => 'Done'
        },
      '7z' => {
        'tool'            => '7z',
        'compress_file'   => 'a',
        'compress_folder' => 'a',
        'decompress'      => 'x',
        'success_message' => 'Everything is Ok'
      },
      'gzip' => {}
    }

    MSG = {
      :unsupported => 'Unsupported archive type!',
      :exception   => 'Exception!',
      :incorrect   => 'Incorrect archive filename!'
    }

    def save_current_dir
      @current_dir = Dir.pwd
    end

    def back_to_last_dir
      chdir(@current_dir)
    end

    def get_folder(path)
      path.split('/')[0..-2].join('/')
    end

    def chdir(folder)
      if File.directory?(folder)
        Dir.chdir(folder)
        true
      else
        false
      end
    end

    def get_file(path)
      file = path.split('/')[-1]
      file ? file : path
    end

    def prepare_test_files
      FileUtils.rm_rf(TEMP_FOLDER, secure: true)
      Dir.mkdir(TEMP_FOLDER)
      Dir.mkdir(TEST_FOLDER)
      Dir.mkdir(TEST_FOLDER_UNCOMPRESSED)
      FileUtils.cp("#{FILE}", TEMP_FOLDER)
      FileUtils.cp("#{FILE}", TEST_FOLDER)
      chdir(HOME)
    end

    def utilize_test_files
      FileUtils.rm_rf("#{TEMP_FOLDER}", secure: true)
      chdir(PROJECT)
    end

    def test(format)
      test_sets = [
        TotalCompressor::BaseCompressor::TEST_FILE,
        TotalCompressor::BaseCompressor::TEST_FOLDER
      ]
      result = {
        :success => true
      }
      prepare_test_files
      test_sets.each do |test_set|
        next if skip_test?(format, test_set)
        res = eval("TotalCompressor::T#{format.capitalize}.new.compress(\'#{test_set}\')")
        if res[:success]
          FileUtils.cp("#{res[:file]}", TEST_FOLDER_UNCOMPRESSED)
          res = eval("TotalCompressor::T#{format.capitalize}.new.decompress(\'#{TEST_FOLDER_UNCOMPRESSED}/#{res[:file].split('/').last}\')")
          result[:success] = false unless res[:success]
        else
          result[:success] = false
        end
      end
      utilize_test_files
      result[:success] ? 'Success' : 'Failure'
    end

    def skip_test?(format, test_set)
      true if File.directory?(test_set) && format == 'gzip'
    end

    def compress(path, format)
      save_current_dir
      result = {
        :success => false
      }
      folder = get_folder(path)
      return result unless chdir(folder)
      begin
        file = get_file(path)
        archive = file + ".#{format}"
        if file
          message = if File.directory?(path)
            %x[#{TYPE[format]['tool']} #{TYPE[format]['compress_folder']} #{archive} #{file}]
          else
            %x[#{TYPE[format]['tool']} #{TYPE[format]['compress_file']} #{archive} #{file}]
          end
          if message && message.match(/#{TYPE[format]['success_message']}/)
            result[:success] = true
            result[:file] = "#{folder}/#{archive}"
          else
            result[:error] = message
          end
        else
          result[:error] = BaseCompressor::MSG[:incorrect]
        end
      rescue
        result[:error] = BaseCompressor::MSG[:exception]
      ensure
        back_to_last_dir
      end
      return_result(result)
    end

    def decompress(path, format)
      save_current_dir
      result = {
          :success => false,
          :files => []
      }
      folder = get_folder(path)
      Dir.chdir(folder)
      begin
        file = get_file(path)
        previous_entries = Dir.entries(Dir.pwd)
        %x[#{TYPE[format]['tool']} #{TYPE[format]['decompress']} #{file}]
        new_entries = Dir.entries(Dir.pwd)
        uncompressed_entries = new_entries - previous_entries
        uncompressed_entries.each{|entry| result[:files] << "#{folder}/#{entry}" }
        result[:success] = true
      rescue
        result[:error] = BaseCompressor::MSG[:exception]
      ensure
        back_to_last_dir
      end
      return_result(result)
    end

    def get_format
      self.class.to_s.split('::').last.downcase[1..-1]
    end

    def return_result(result)
      ap result unless result[:success]
      result
    end
  end
end