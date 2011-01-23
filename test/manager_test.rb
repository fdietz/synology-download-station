require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class ManagerTest < Test::Unit::TestCase
  
  def setup
    @host = "diskstation"
    @port = 5000
    @user = "user"
    @password = ""
    @manager = SynologyDownloadStation::Manager.new(@host, @port, @user, @password)
  end
  
  # def test_get_conf
  #   p @manager.get_conf
  # end
    
  def test_get_conf
    response = { :dl_enable => 1, :dl_order => 0, :success => true }
    Nestful.expects(:get).returns(response.to_json)
    assert @manager.get_conf
  end

  # def test_login
  #   p @manager.login
  # end

  def test_login
    Nestful.expects(:get).returns( { :login_success => true, :success => true }.to_json)
    assert @manager.login
  end
  
  def test_login_success
    Nestful.expects(:get).returns( { :login_success => true, :success => true }.to_json)
    assert @manager.login.login_success
  end
  
  def test_login_error
    Nestful.expects(:get).returns( { :login_success => false, :success => true }.to_json) 
    assert_raise(SynologyDownloadStation::Response::LoginError) do
      @manager.login
    end
  end
  
  def test_share_get
    @manager.stubs(:logged_in?).returns(true)
    Nestful.expects(:get).returns( { :success => true }.to_json)
    assert @manager.share_get
  end

  # def test_share_get
  #   p @manager.share_get
  # end

  def test_get_all
    @manager.stubs(:logged_in?).returns(true)
    Nestful.expects(:get).returns( { :success => true }.to_json)
    assert @manager.get_all
  end
  
  # def test_get_all
  #   p @manager.get_all
  # end

  # def test_get_all
  #   p @manager.get_all_sort_by_task_id
  # end

  def test_add_url
    @manager.stubs(:logged_in?).returns(true)
    Nestful.expects(:get).returns( { :success => true }.to_json)
    assert @manager.add_url("http://test.de/test.zip")
  end
  
  # def test_add_url
  #   p @manager.add_url("http://user@pass:dl.btjunkie.org/torrent/Ubuntu-9-10-desktop-i386-CD/365098c5c361d0be5f2a07ea8fa5052e5aa48097e7f6/download.torrent")
  # end

end