module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def json_request_headers
      { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    end
  end
end
