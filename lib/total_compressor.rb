require 'total_compressor/version'
require 'zip/zip'
require 'awesome_print'

module TotalCompressor
  class BaseCompressor; end
  class TZip < BaseCompressor; end
  class TGzip < BaseCompressor; end
  class TRar < BaseCompressor; end
  class T7z < BaseCompressor; end

  class << self
    def cmdline
      case ARGV.size
        when 1
          decompress(ARGV[0])
        when 2
          compress(ARGV[1], BaseCompressor::HASH_TYPE[ARGV[0]]) if BaseCompressor::HASH_TYPE[ARGV[0]]
        else
          raise
      end
    rescue
      show_help
    end

    def compress(path, format)
      if BaseCompressor::TYPE[format]
        eval("TotalCompressor::T#{format.capitalize}.new.compress(\'#{path}\')")
      else
        ap BaseCompressor::MSG[:unsupported]
      end
    end

    def decompress(path)
      format = path.split('.')[-1]
      if BaseCompressor::TYPE[format]
        eval("TotalCompressor::T#{format.capitalize}.new.decompress(\'#{path}\')")
      else
        ap BaseCompressor::MSG[:unsupported]
      end
    end

    def test
      result = []
      compressors = constants
      compressors -= [:BaseCompressor, :VERSION]
      compressors.each do |compressor|
        result << eval("TotalCompressor::#{compressor.to_s}.new.test")
      end
      result
    end

    def show_help
      puts %Q{
      Total Compressor, v0.1, 2013, MIT License, https://github.com/phlowerteam
      Tool (wrapper) for compression and handling multiple type of archives.

      Usage: tcomp [<key>] path
        <key> - determine supported type of compression:
          z - use Zip
          g - use GZip (can't compress folder, only file)
          r - use RAR
          7 - use 7z

      Examples:
        tcomp z '/home/alex/The Lord of the Rings.txt'  # creates '/home/alex/The Lord of the Rings.txt.zip'
        tcomp /home/alex/Hobbit.txt.7z                  # creates /home/alex/Hobbit.txt
      }
    end
  end
end

load 'lib/total_compressor/compressors/base_compressor.rb'
load 'lib/total_compressor/compressors/t_zip.rb'
load 'lib/total_compressor/compressors/t_gzip.rb'
load 'lib/total_compressor/compressors/t_rar.rb'
load 'lib/total_compressor/compressors/t_7z.rb'