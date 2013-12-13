require 'spec_helper'
require 'total_compressor'

describe TotalCompressor do
  it 'Test all compressors' do
     TotalCompressor.test.join.should_not match(/Failure/)
  end
end