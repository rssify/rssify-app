module Rssify
  class Feedable
    class Utils
      DATE_FORMAT = '%FT%TZ'

      class << self
        def formatted_time(time)
          time.utc.strftime(DATE_FORMAT)
        end
      end
    end
  end
end
