module TotalCompressor
  class T7z < BaseCompressor
    def test
      super(get_format)
    end

    def compress(path)
      super(path, get_format)
    end

    def decompress(path)
      super(path, get_format)
    end
  end
end