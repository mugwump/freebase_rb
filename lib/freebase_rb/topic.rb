module FreebaseRb
  class Topic
    @raw_data = nil

    def initialize(id_or_hash)
      if id_or_hash.is_a?(String)
        response = API.get(id)
      else
        response = id_or_hash
      end
      init_with_response(response)
      return nil if @raw_data.blank?
      self
    end

    def init_with_response(response)
      @raw_data = response
    end

    def description
      begin
        @raw_data["description"] ||= API.description(id)
      rescue FreebaseRb::ResponseException
        @raw_data["description"] = "No description available"
      end

    end

    def raw_data
      @raw_data
    end

    def get_property(property_name)
      property = property_name.to_s

      return nil if @raw_data.blank?

      return description if property == "description"

      return @raw_data[property] unless @raw_data[property].blank?
      unless @raw_data['type'].blank?
        id = "#{@raw_data['type']}/#{property}"
        return @raw_data[id] unless @raw_data[id].blank?
      end
      mql = {
        "id" => get_property(:id),
        property => nil
      }
      result = API.mqlread(mql)
      @raw_data[property] = result[property]
      return @raw_data[property]
    end

    def [](key)
      get_property(key)
    end

    def to_s
      "#{id}: #{description}"
    end

    def inspect
      "#{id}: #{description}"
    end

    # implemented to get proper puts-support without running into issues with the method_missing-implementation
    def to_ary
      ["#{id}: #{description}", @raw_data]
    end

    private

    def method_missing(method, *args)
      get_property(method)
    end


  end
end