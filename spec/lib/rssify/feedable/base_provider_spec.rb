require 'rails_helper'

describe Rssify::Feedable::BaseProvider do
  describe '#initialize' do
    it 'allows to pass uri as a string' do
      PARAMS = {
        'example.com/path' => 'http://example.com/path',
        'http://example.com/path' => 'http://example.com/path',
        'https://example.com/path' => 'https://example.com/path'
      }

      PARAMS.each do |key, value|
        expect(Rssify::Feedable::BaseProvider.new(key).link).to eq URI(URI.encode(value))
      end
    end
  end
end
