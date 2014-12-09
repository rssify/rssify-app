require 'rails_helper'

describe Rssify::Feedable::Utils do
  describe '.formatted_time' do
    let(:time) { Time.parse('2013-09-09 12:00:00') }

    it { expect(Rssify::Feedable::Utils.formatted_time(time)).to eq '2013-09-09T12:00:00Z' }
  end
end
