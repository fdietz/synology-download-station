module SynologyDownloadStation
  module Response
    
    # { :success => true, 
    #     :items => [ 
    #       {
    #         "pid"=>-1, 
    #         "uploadRate"=>1078, 
    #         "extraInfo"=>"[{\"name\":\"/ubuntu-9.10-desktop-i386.iso\",\"pr\":1,\"size\":\"723488768\"}]\n", 
    #         "createdTime"=>1292974489, 
    #         "totalPeers"=>60, 
    #         "downloadedPieces"=>243, 
    #         "currentRate"=>1236113, 
    #         "availablePieces"=>0, 
    #         "username"=>"admin", 
    #         "url"=>"http://dl.btjunkie.org/torrent/Ubuntu-9-10-desktop-i386-CD/365098c5c361d0be5f2a07ea8fa5052e5aa48097e7f6/download.torrent", 
    #         "totalPieces"=>1380, 
    #         "seedingRatio"=>0, 
    #         "seedingInterval"=>0, 
    #         "progress"=>" 20.3%", 
    #         "totalUpload"=>77473, 
    #         "id"=>8, 
    #         "currentSize"=>"140.02 MB", 
    #         "totalSize"=>"689.97 MB", 
    #         "startedTime"=>1292974496, 
    #         "filename"=>"ubuntu-9.10-desktop-i386.iso", 
    #         "connectedPeers"=>46, 
    #         "status"=>3 
    #         }
    #     ]
    # }    
    class Item
      attr_reader :response
      
      STATUS = { 3 => :paused, 6 => :running }
      PAUSED = 3
      RUNNING = 6
      COMPLETED = 5
      BROKEN_LINK = 102
      
      def initialize(response)
        @response = response
      end
      
      def id
        response[:id]
      end
      
      def status
        response[:status]
      end
      
      def progress
        response[:progress]
      end
      
      def filename
        response[:filename]
      end
      
      def url
        response[:url]
      end
      
      def current_rate
        response[:currentRate]
      end
      
      def peers
        response[:connectedPeers]
      end
      
      def paused?
        response[:status] == PAUSED
      end
      
      def running?
        response[:status] == RUNNING
      end
    end
    
  end
end