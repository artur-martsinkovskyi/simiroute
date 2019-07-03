module Lambdas
  class Lambda
    def call(payload:)
      raw_response = client.invoke(
        payload: JSON.dump(process_payload(payload)),
        function_name: function_name,
        log_type: 'None',
        invocation_type: 'RequestResponse'
      )
      response = Response.new(raw_response)
      process_response(response)
    end

    private

    def client
      @client ||= Aws::Lambda::Client.new
    end

    def process_payload(*)
      raise NotImplementedError
    end

    def process_response(*)
      raise NotImplementedError
    end
  end
end
