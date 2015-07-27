require "cache_builder/cache_block_extractors/fragment_cache_extractor"

module CacheBlockConfigWriter
  
  def self.create_config_file(directories)
  	cache_block_config = []
  	directories.each do |directory|
  	  cache_block_config << FragmentCacheExtractor.extract_block(directory)
  	end
  	File.open("config/cache_builder.yml", "w") do |file|
      file.write cache_block_config.compact.to_yaml
    end
  end  
end