require "cache_builder/version"
require "cache_builder/cache_block_extractors/cache_blog_config_writer"

module CacheBuilder
  
  class CacheBuilderTasks < Rails::Railtie
  	rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end
  end

end
