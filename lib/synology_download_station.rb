$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

# require "bundler"
# Bundler.setup

require "nestful"
require 'json'

require "synology_download_station/manager"
require "synology_download_station/response/base"
require "synology_download_station/response/login"
require "synology_download_station/response/get_all"
require "synology_download_station/response/share_get"
require "synology_download_station/response/get_conf"
require "synology_download_station/response/add_url"

module SynologyDownloadStation
  VERSION = File.read(File.dirname(__FILE__) + "/../VERSION").chomp
end