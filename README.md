total_compressor
================

Tool (wrapper) for compression and handling multiple type of archives.

Supports next archive types:
   - Zip;
   - GZip;
   - RAR;
   - 7z.

## Installation

Install appropriate tools before using:

    apt-get install zlib1g zlib1g-dev zip rar p7zip

Add this line to your application's Gemfile:

    gem 'total_compressor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install total_compressor

## Usage

Command line:  tcomp [<key>] path
    <key> - determine supported type of compression:
        z - use Zip
        g - use GZip
        r - use RAR
        7 - use 7z

Examples:
    tcomp z '/home/alex/The Lord of the Rings.txt'  # creates '/home/alex/The Lord of the Rings.txt.zip'
    tcomp /home/alex/Hobbit.txt.7z                  # creates /home/alex/Hobbit.txt

API:

    require 'total_compressor'

    TotalCompressor.compress('/home/alex/Hobbit.txt', 'zip')  # => '/home/alex/Hobbit.txt.zip'
    TotalCompressor.compress('/home/alex/Hobbit.txt', 'gzip') # => '/home/alex/Hobbit.txt.gzip'
    TotalCompressor.compress('/home/alex/Hobbit.txt', 'rar')  # => '/home/alex/Hobbit.txt.rar'
    TotalCompressor.compress('/home/alex/Hobbit.txt', '7z')   # => '/home/alex/Hobbit.txt.7z'

    TotalCompressor.decompress('/home/alex/Hobbit.txt.7z')    # => '/home/alex/Hobbit.txt'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contacts

https://github.com/phlowerteam

phlowerteam@gmail.com

## License

Copyright (c) 2013 PhlowerTeam

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
