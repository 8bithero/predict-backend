module Requests
  module JsonHelpers
    def json
      begin
        @json ||= JSON.parse(response.body)
      rescue
        raise "Couldn't parse JSON '#{response.body}'"
      end
    end
  end
end

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :request
end
