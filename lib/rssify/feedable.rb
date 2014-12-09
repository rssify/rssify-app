module Rssify
  class Feedable
    @providers = [
      Rssify::Feedable::Vkontakte
    ]

    class << self
      def parse_link(link)
        link = "http://#{link}" unless link =~ %r{\Ahttps?:\/\/}
        parsed_link = URI(URI.encode(link))

        provider = self[parsed_link.host]
        fail ArgumentError, "#{link.inspect} uri is not supported" unless provider

        provider.new(parsed_link.to_s)
      end

      def [](host)
        @providers.find { |provider| host =~ provider::MASK }
      end
    end
  end
end
