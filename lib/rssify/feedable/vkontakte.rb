module Rssify
  class Feedable
    class Vkontakte < BaseProvider
      MASK = /vk\.com|vkontakte\.ru/

      def valid?
        !resolve_screen_name.blank?
      end

      def feed
        return unless valid?

        response = wall_get owner_id

        FeedBuilder.new(response).feed
      end

      def screen_name
        @screen_name ||= link.path.split('/')[1]
      end

      def owner_id
        return unless valid?

        resolve_screen_name['object_id'].to_i
      end

      def owner_type
        return unless valid?

        resolve_screen_name['type']
      end

      private

      def api_client
        @api_client ||= VkontakteApi::Client.new
      end

      def wall_get(owner_id)
        api_client.wall.get extended: 1, owner_id: owner_id, filter: 'owner', count: 20
      end

      def resolve_screen_name
        @resolve_screen_name ||= api_client.utils.resolve_screen_name screen_name: screen_name
      end
    end
  end
end
