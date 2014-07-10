require 'gems'
require 'logger'

class Rubygems
  attr_reader :options
  
  def initialize options = {}
    @options = options
  end
  
  def logger
    @logger ||= begin
      l = Logger.new(STDERR)
      if options[:verbose] || options[:noop]
        l.level = Logger::DEBUG 
      else
        l.level = Logger::INFO
      end
      l
    end
  end
  
  def gems
    @gems ||= Gems.gems(options[:user])
  end
  
  def add_rubygems_owners owners
    gems.each do |g|
      logger.warn "===== #{g['name']} ====="
      current_owners = Gems.owners(g['name']).map { |x| x['email'] }
      
      (owners - current_owners).each do |o|
        logger.info "Adding #{o} to #{g['name']}"
        Gems.add_owner g['name'], o unless options[:noop]
      end
      
      logger.warn "Non-developers listed: #{current_owners - owners}"
    end
  end
end
