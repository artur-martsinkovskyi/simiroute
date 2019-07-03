module Lambdas
  class DistanceLambda < Lambda
    FUNCTION_NAME = 'getTravelledDistance'

    private

    def process_payload(payload)
      {
        trackpoints: payload
      }
    end

    def process_response(response)
      response.body['distance']
    end

    def function_name
      FUNCTION_NAME
    end
  end
end
