require 'gmo'
require 'sphy_gmo/api_error'
require 'sphy_gmo/card'
require 'sphy_gmo/member'
require 'sphy_gmo/transaction'
require "sphy_gmo/version"

module SphyGmo
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :host, :site_id, :site_pass, :shop_id, :shop_pass
  end

  def self.gmo_site
    ::GMO::Payment::SiteAPI.new(configuration)
  end

  def self.gmo_shop
    ::GMO::Payment::ShopAPI.new(configuration)
  end

  def self.path_to_resources(path)
    File.join(File.dirname(File.expand_path(__FILE__)), '..', path)
  end
end
