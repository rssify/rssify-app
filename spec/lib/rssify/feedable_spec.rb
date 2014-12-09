require 'rails_helper'

describe Rssify::Feedable do
  describe '.parse_link' do
    let(:feedable) { Rssify::Feedable.parse_link(link) }

    context 'when link matches vk.com' do
      let(:link) { 'vk.com/durov' }

      it { expect(feedable).to be_a Rssify::Feedable::Vkontakte }
    end

    context 'when link matches vkontakte.ru' do
      let(:link) { 'vkontakte.ru/durov' }

      it { expect(feedable).to be_a Rssify::Feedable::Vkontakte }
    end

    context 'when link does not match any provider' do
      let(:link) { 'example.com/path' }

      it { expect { feedable }.to raise_error ArgumentError }
    end
  end
end
