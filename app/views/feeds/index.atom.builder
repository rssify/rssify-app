atom_feed do |feed|
  feed.title @feed.title
  feed.url @feed.url

  @feed.entries.each do |feed_entry|
    feed.entry(feed_entry, { url: feed_entry.url }) do |entry|
      entry.title feed_entry.title
      entry.content feed_entry.summary, type: 'html'

      entry.author do |author|
        author.name feed_entry.author_name
        author.photo feed_entry.author_photo
      end
    end
  end
end
