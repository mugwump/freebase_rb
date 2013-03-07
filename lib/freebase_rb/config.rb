module FreebaseRb
  class Config
    class << self
      attr_reader :settings
    end

    @settings = {
      :api_key => nil,
      :logging => false,
      :cache => {
        :is_active => false,
        :expires_in => 1.day
      }
    }

    def self.api_key(api_key)
      @settings[:api_key] = api_key
    end

    def self.cache(options)
      @settings[:cache].merge!(options)
    end

    def logging(is_enabled)
      @settings[:api_key] = is_enabled
    end
  end
end