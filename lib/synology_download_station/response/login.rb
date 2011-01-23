module SynologyDownloadStation
  module Response
    
    class LoginError < StandardError; end
    
    # {"login_success"=>true, "id"=>"FsEr6MGnWj59o", "success"=>true}
    class Login < Base
      
      def parse_response
        raise LoginError.new(response.inspect) unless login_success
      end
      
      def login_success
        response[:login_success] || false
      end
      
      def id
        response[:id]
      end
      alias :token :id
      
    end
    
  end
end