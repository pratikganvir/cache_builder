module CacheViewRenderer
  class MetalTestController < ActionController::Metal
    include AbstractController::Logger
    include AbstractController::Rendering
    include ActionView::Layouts if defined?(ActionView::Layouts) # Rails 4.1.x
    include AbstractController::Layouts if defined?(AbstractController::Layouts) # Rails 3.2.x, 4.0.x
    include AbstractController::Helpers
    include AbstractController::Translation
    include AbstractController::AssetPaths
    include ActionController::Caching
    helper_method :protect_against_forgery?
    attr_accessor :template
    attr_accessor :input
    attr_accessor :rails_root

    def initialize(*args)
      super()

      self.class.send :include, Rails.application.routes.url_helpers

      if defined?(ApplicationHelper)
        self.class.send :helper, ApplicationHelper
      end

      config.javascripts_dir = Rails.root.join('public', 'javascripts')
      config.stylesheets_dir = Rails.root.join('public', 'stylesheets')
      config.assets_dir = Rails.root.join('public')
      config.cache_store = ActionController::Base.cache_store
      self.asset_host = ActionController::Base.asset_host
    end

    def protect_against_forgery?
      false
    end

    def flash
      {}
    end

    def request
      OpenStruct.new
    end

    def params
      {}
    end

    def cookies
      {}
    end

   def render_cache_template
     append_view_path "#{rails_root}/cache_builder/views"
     append_view_path "#{rails_root}/app/views"
     eval(input).each do |variable,value|
      instance_variable_set(variable, value) if variable.to_s.include?("@")
     end if input
     render :template =>  @template
   end

  end

end