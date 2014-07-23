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
      current_owners = Gems.owners(g['name']).map { |x| x['email'] }
      
      owners_to_add = owners - current_owners
      owners_to_remove = current_owners - owners - [options[:user]]
      
      if owners_to_add.empty? and owners_to_remove.empty?
        next
      end
      
      logger.warn "===== #{g['name']} ====="s
      
      owners_to_add.each do |o|
        logger.debug "Adding #{o} to #{g['name']}"
        Gems.add_owner g['name'], o unless options[:noop]
      end
      
      owners_to_remove.each do |o|
        logger.warn "$ gem owner #{g['name']} -r #{o}"
      end

    end
  end
end
