module SynologyDownloadStation
  module Response
    
    # {
    #    "share_folder" : "video",
    #    "success" : true,
    #    "user_disabled" : false
    # }
    class ShareGet < Base
      
      def parse_response
      end
      
      def share_folder
        response[:share_folder]
      end
      
      def user_disabled
        response[:user_disabled]
      end
    end
    
  end
end