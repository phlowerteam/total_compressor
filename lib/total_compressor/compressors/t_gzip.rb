module TotalCompressor
  class TGzip < BaseCompressor
    def test
      super(get_format)
    end

    def compress(path)
      save_current_dir
      result = {
        :success => false
      }
      raise if File.directory?(path)
      folder = get_folder(path)
      return result unless chdir(folder)
      begin
        file = get_file(path)
        archive = file + ".#{get_format}"
        Zlib::GzipWriter.open("#{path}.gzip") do |gz|
          gz.write(IO.read(path))
          result = {
            :success => true,
            :file    => "#{folder}/#{archive}"
          }
        end
      rescue
        result[:error] = 'exception'
      ensure
        back_to_last_dir
      end
      return_result(result)
    end

    def decompress(path)
      save_current_dir
      result = {
        :success => false,
        :files => []
      }
      begin
        Zlib::GzipReader.open(path) do |gz|
          file = path.split('.')[0..-2].join('.')
          IO.write(file, gz.read)
          result = {
            :success => true,
            :file    => file
          }
        end
      rescue
        result[:error] = 'exception'
      ensure
        back_to_last_dir
      end
      return_result(result)
    end
  end
end