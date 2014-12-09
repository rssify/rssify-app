module Rssify
  class FeedEntry
    attr_accessor :id, :title, :created_at, :updated_at, :url, :summary, :author

    delegate :name, :photo, to: :author, prefix: true, allow_nil: true
  end
end
