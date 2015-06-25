require 'gmo'
require 'sphy_gmo/api_error'
require 'sphy_gmo/card'
require 'sphy_gmo/member'
require 'sphy_gmo/stub'
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
    CONFIGS = [:host, :site_id, :site_pass, :shop_id, :shop_pass]
    attr_accessor *CONFIGS

    def [](key)
      raise "#{key} must be valid entry: #{CONFIGS.inspect}" unless CONFIGS.include? key.to_sym
      send(key)
    end

    def []=(key,value)
      raise "#{key} must be valid entry: #{CONFIGS.inspect}" unless CONFIGS.include? key.to_sym
      send("#{key}=", value)
    end

    def to_h
      Hash[ CONFIGS.map {|attr| [attr, self.send(attr)]} ]
    end
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
