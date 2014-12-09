require 'rails_helper'

describe Rssify::Feedable::Vkontakte do
  describe '#screen_name' do
    it 'returns screen name of passed url' do
      expect(Rssify::Feedable::Vkontakte.new('http://vk.com/durov').screen_name).to eq 'durov'
      expect(Rssify::Feedable::Vkontakte.new('http://vkontakte.ru/id1').screen_name).to eq 'id1'
    end
  end

  describe '#valid?', :vcr do
    context 'when vk api returns empty result' do
      let(:feedable) { Rssify::Feedable::Vkontakte.new('http://vk.com/some_fake_url') }

      it { expect(feedable.valid?).to eq false }
      it { expect(feedable.owner_id).to eq nil }
      it { expect(feedable.owner_type).to eq nil }
    end

    context 'when vk api returns result' do
      let(:feedable) { Rssify::Feedable::Vkontakte.new('http://vk.com/durov') }

      it { expect(feedable.valid?).to eq true }
      it { expect(feedable.owner_id.to_s).to eq '1' }
      it { expect(feedable.owner_type).to eq 'user' }
    end
  end

  describe '#feed', :vcr do
    let(:feedable) { Rssify::Feedable::Vkontakte.new('http://vk.com/durov') }

    it 'returns feed object for the url' do
      feed = feedable.feed

      expect(feed.title).to eq 'Павел Дуров'
      expect(feed.url).to eq 'http://vk.com/durov'
      expect(feed.updated_at).to eq '2014-11-20T19:03:42Z'
      expect(feed.entries.count).to eq 20
      expect(feed.entries.first.title).to eq 'Мда.'
      expect(feed.entries.first.url).to eq 'https://vk.com/durov?w=wall1_45635'
      expect(feed.entries.first.updated_at).to eq '2014-11-20T19:03:42Z'
      expect(feed.entries.first.summary).to eq 'Мда.'
      expect(feed.entries.first.author_name).to eq 'Павел Дуров'
      expect(feed.entries.first.author_photo).to eq 'http://cs9591.vk.me/v9591001/73/HtS1Z99qMDU.jpg'
    end
  end
end
