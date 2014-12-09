module Rssify
  class Feedable::Vkontakte::FeedBuilder
    attr_reader :feed

    def initialize(response)
      @response = response

      @feed = Rssify::Feed.new.tap do |feed|
        feed.title = generate_feed_title
        feed.updated_at = generate_feed_updated_at
        feed.url = generate_feed_url
        feed.entries = generate_feed_entries
      end
    end

    private

    def generate_feed_title
      [profile.first_name, profile.last_name].join ' '
    end

    def generate_feed_url
      "http://vk.com/#{profile.screen_name}"
    end

    def generate_feed_updated_at
      Time.at(items.first.date)
    end

    def generate_feed_entries
      items.map do |entry|

        FeedEntry.new.tap do |feed_entry|
          feed_entry.id = entry.id
          feed_entry.title = generate_entry_title(entry)
          feed_entry.updated_at = generate_entry_updated_at(entry)
          feed_entry.created_at = generate_entry_updated_at(entry)
          feed_entry.url = generate_entry_url(entry)
          feed_entry.summary = generate_entry_summary(entry)
          feed_entry.author = generate_author(entry)
        end
      end
    end

    def generate_entry_title(entry)
      if entry.copy_history
        entry.copy_history[0].text.truncate(80, omission: '...')
      else
        entry.text.truncate(80, omission: '...')
      end
    end

    def generate_entry_updated_at(entry)
      Time.at(entry.date)
    end

    def generate_entry_url(entry)
      "https://vk.com/durov?w=wall#{entry.from_id}_#{entry.id}"
    end

    def generate_entry_summary(entry)
      if entry.copy_history
        entry.copy_history[0].text
      else
        entry.text
      end
    end

    def generate_author(entry)
      @authors ||= {}

      @authors[entry.from_id] ||= FeedAuthor.new.tap do |author|
        profile = profiles.find { |p| p.id == entry.from_id }

        author.name = [profile.first_name, profile.last_name].join ' '
        author.photo = profile.photo_100
      end
      @authors[entry.from_id]
    end

    def profile
      @profile ||= profiles.find { |p| p.id == items.first.owner_id }
    end

    def profiles
      @profiles ||= @response.profiles
    end

    def items
      @items ||= @response.items
    end
  end
end
