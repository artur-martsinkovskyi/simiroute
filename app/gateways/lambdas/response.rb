module Lambdas
  class Response
    def initialize(raw_response)
      @raw_response = raw_response
    end

    def body
      @body ||= JSON.parse(response['body'])
    end


    def status
      response['statusCode']
    end

    private

    def response
      @response ||= JSON.parse(raw_response.payload.string)
    end

    attr_reader :raw_response
  end
end
