module SynologyDownloadStation
  module Response
    
    class ResponseError < StandardError; end
    
    class Base
      
      attr_reader :response, :success
      
      def initialize(response)
        @raw_response = response
        @response = JSON.parse(response).symbolize_keys!
        raise ResponseError.new("Request Failed:\n#{@response.inspect}") unless success?
        
        parse_response
      end
      
      def success?
        response[:success]
      end
    
      protected
      
        def parse_response
          raise "Subclasses implement me!"
        end
        
    end
    
  end
end