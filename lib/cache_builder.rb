require "cache_builder/version"
require "cache_builder/cache_block_extractors/cache_blog_config_writer"
require "cache_builder/renderer/template_renderer"

module CacheBuilder
  
  class CacheBuilderTasks < Rails::Railtie
  	rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end
  end

  class Build
  	def self.process(rails_root=nil)
  		configuration = YAML.load_file("config/cache_builder.yml")
      configuration.each do |cache_file_configuration|
        begin
          renderer = CacheViewRenderer::MetalTestController.new
          renderer.template = cache_file_configuration[:cache_block_files][:file_name].
          gsub("cache_builder/views/","")
          renderer.input = cache_file_configuration[:input]
          renderer.rails_root = rails_root
          renderer.render_cache_template
        rescue Exception => e
          puts e.backtrace
          puts e.message
        end
      end
  	end
  end

end
