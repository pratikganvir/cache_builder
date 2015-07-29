namespace :cache_builder do
  desc "Scan rails application for caches"

  task :scan_fragment_caches => :environment do
  	Dir['app/**/*.*'].each do |file_path|
  	  FragmentCacheExtractor.extract_block(file_path)
  	end
  end

  task :create_configuration => :environment do
    CacheBlockConfigWriter.create_config_file(Dir['app/**/*.*'])
  end

  task :create_fragment_cache => :environment do
  	CacheBuilder::Build.process(Rails.root)
  end
end