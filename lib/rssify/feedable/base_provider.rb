module Rssify
  class Feedable
    class BaseProvider
      attr_reader :link

      def initialize(link)
        link = "http://#{link}" unless link =~ %r{\Ahttps?:\/\/}
        @link = URI(URI.encode(link))
      end
    end
  end
end
