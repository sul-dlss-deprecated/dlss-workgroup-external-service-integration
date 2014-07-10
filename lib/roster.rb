require 'confluence4r'
require 'nokogiri'
require 'csv'
class Roster  
  
  class Config
    def self.env
      "production"
    end

    def self.config_file
      ENV['CONFLUENCE_CONFIG_YML'] || "./config/confluence.yml"
    end

    def self.config
      @config ||= begin
        raise "The #{env} environment settings were not found in the solr.yml config" unless yml[env]
        yml[env]
      end
    end

    def self.yml
      require 'erb'
      require 'yaml'

      return @yml if @yml
      unless File.exists?(config_file)
        raise "You are missing a confluence configuration file: #{config_file}."  
      end

      begin
        @erb = ERB.new(IO.read(config_file)).result(binding)
      rescue Exception => e
        raise("confluence.yml was found, but could not be parsed with ERB. \n#{$!.inspect}")
      end

      begin
        @yml = YAML::load(@erb)
      rescue StandardError => e
        raise("confluence.yml was found, but could not be parsed.\n")
      end

      if @yml.nil? || !@yml.is_a?(Hash)
        raise("confluence.yml was found, but was blank or malformed.\n")
      end

      return @yml
    end
  end

  def self.client config = {}
    @client ||= begin
      c = Confluence::RPC.new config["host"]
      c.login config["username"], config["password"]
      c
    end
  end
  
  attr_reader :client
  attr_reader :page_id
  attr_reader :options
  
  def initialize client, page_id, options
    @client = client
    @page_id = page_id
    @options = options
  end
  
  def page
    @page ||= client.getPage page_id
  end
  
  def content
    @content ||= client.renderContent "", page_id, ""
  end
  
  def doc
    @doc ||= Nokogiri::HTML(content)
  end
  
  def table
    @table ||= begin
      title = doc.css('h1,h2,h3,h4').select { |x| x.text =~ /#{options[:header]}/ }.first
      
      table = nil
      
      # look for a table shortly after the title
      e = title
      table = 5.times do
        e = e.next_element
        if e.css('table').any?
          break e.css('table').first
        end
      end
      table
    end
  end
  
  def to_csv
    s = CSV.generate do |csv|
      table.css('tr').each do |row|
        csv << row.css('td,th').map { |x| x.text.gsub(/[[:space:]]/, ' ').strip }
      end
    end
    
    CSV.parse(s, headers: true)
  end
end
