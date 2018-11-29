module TotalCompressor
  class TZip < BaseCompressor
    def test
      super(get_format)
    end

    def compress(path)
      super(path, get_format)
    end

    def decompress(path)
      save_current_dir
      result = {
        :success => false,
        :files => []
      }
      begin
        folder = get_folder(path)
        Zip::File.open(path) do |zip_file|
          dir = zip_file
          dir.entries.each do |file|
            zip_file.extract(file, "#{folder}/#{file}")
            result[:files] << "#{folder}/#{file}"
          end
        end
        result[:success] = true
      rescue
        result[:error] = 'exception'
      ensure
        back_to_last_dir
      end
      return_result(result)
    end
  end
end
