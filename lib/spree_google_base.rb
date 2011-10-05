require 'spree_core'

module SpreeGoogleBase
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/**/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      
      if Spree::Config.instance
        Taxon.has_one :taxon_map
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
