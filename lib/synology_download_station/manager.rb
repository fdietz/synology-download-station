module SynologyDownloadStation
  class Manager
    
    attr_reader :host, :port, :user, :password, :token
    
    DOWNLOAD_DIRECTOR_PATH = "download/download_redirector.cgi"
    #DOWNLOAD_DOWNLOADMAN_PATH = "download/downloadman.cgi"
    
    def initialize(host, port, user, password)
      @host = host
      @port = port
      @user = user
      @password = password
    end
    
    def get_conf
      response = Nestful.get(request_url, :params => { :action => 'getconf' })
      SynologyDownloadStation::Response::GetConf.new(response)
    end
    
    def login
      response = Nestful.get(request_url, :params => { :action => 'login', :username => user, :passwd => password })
      login = SynologyDownloadStation::Response::Login.new(response)
      raise LoginError.new(response.inspect) unless login.login_success
      @token = login.id
      login
    end
    
    def share_get
      login unless logged_in?
      
      response = Nestful.get(request_url, :params => { :action => 'shareget', :id => token, :username => user })
      SynologyDownloadStation::Response::ShareGet.new(response)
    end
    
    def get_all(options = {})
      login unless logged_in?
      
      response = Nestful.get(request_url, :params => { :action => 'getall', :id => token, :username => user}.merge(options))
      SynologyDownloadStation::Response::GetAll.new(response)
    end

    def get_all_sort_by(attribute, ascending = true)
      get_all(:sort => attribute, :dir => ascending ? 'ASC' : 'DESC')
    end
    
    def get_all_sort_by_task_id
      get_all(:start => 0, :limit => 25, :sort => 'task_id', :dir => 'ASC')
    end
    
    def add_url(url)
      login unless logged_in?
      
      response = Nestful.get(request_url, :params => { :action => 'addurl', :url => URI.encode(url), :id => token, :username => user})
      SynologyDownloadStation::Response::AddUrl.new(response)
    end

    def resume(id)
      login unless logged_in?
      
      response = Nestful.post(request_url, :params => { :action => 'resume', :idList => id })
      SynologyDownloadStation::Response::Resume.new(response)
    end

    def stop(id)
      login unless logged_in?
      
      response = Nestful.post(request_url, :params => { :action => 'stop', :idList => id })
      SynologyDownloadStation::Response::Stop.new(response)
    end

    def delete(id)
      login unless logged_in?
      
      response = Nestful.post(request_url, :params => { :action => 'delete', :idList => id })
      SynologyDownloadStation::Response::Delete.new(response)
    end
    
    # def download(url, options = {})
    #   response = Nestful.post(downloadman_request_url, :format => :form, 
    #     :params => options)
    # end
    
    def logout
      @token = nil
    end
    
    def logged_in?
      token != nil
    end
    
    private
      
      def request_url
        "http://#{host}:#{port}/#{DOWNLOAD_DIRECTOR_PATH}"
      end
      
      def downloadman_request_url
        "http://#{host}:#{port}/#{DOWNLOAD_DOWNLOADMAN_PATH}"
      end
          
  end
end
