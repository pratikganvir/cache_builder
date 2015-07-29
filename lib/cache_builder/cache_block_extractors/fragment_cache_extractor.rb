require 'securerandom'
module FragmentCacheExtractor

  # Scan all the lines of the erb file and check for the cache block
  # Writes the blocks into configuration file config/cache_manager.yml
  # Example: extract_block('path/to/erb_file')
  # where erb file containes ->
  #<!- ERB file begining >
  # line1
  # line2
  # <% cache do %>
  # block1
  # block2
  # <% if condition %>
  #   inner_block1
  #   inner_block2
  # <% end %>
  # block3
  # block4
  # <% unless condition %>
  #   inner_block1
  #   inner_block1
  # <% end %>
  # block5
  # block6
  # <% end %>
  # line 3
  # line4
  # <% cache do %>
  #   second_block1
  #   second_block2
  # <% end %>
  # line5
  # line6
  #< ERB file ending -!>
  #The method will outputl all cache blocks like this:
  # <% cache do %>
  # block1
  # block2
  # <% if condition %>
  #   line1
  #   line2
  # <% end %>
  # block3
  # block4
  # <% unless condition %>
  #   line1
  #   line2
  # <% end %>
  # block5
  # block6
  # <% end %>
  # <% cache do %>
  # second_block1
  # second_block2
  # <% end %>

  def self.extract_block(file_path)
    blocks = []
    block = []
    block_found = false
    nested_block_count = 0
    keywords = ["do","if","unless","while","until"]
        cache_block_info = {file_name: file_path, :cache_block_files => {}}

    File.open(file_path).each_line.with_index do |line,index|
        if line.include?("<%") && line.include?("cache") && line.include?("do") && !line.include?("end")
          block_found = true
          block = []
        end

      if block_found
          block << line
        end

        if block_found && line.include?("<%") && keywords.any? { |word| line.include?(word) } && !line.include?("end")  
          nested_block_count += 1
        end

        if block_found && nested_block_count > 0 && line.include?("<%") && (line.include?(" end ")||line.include?("<%end%>")) && line.include?("%>")
          nested_block_count -= 1
        end

        if block_found && nested_block_count == 0 && line.include?("<%") && line.include?("end")
          block_found = false
          blocks << Array.new(block)
        end

    end

    if blocks.present?
      
      directory_name = "cache_builder/"+File.dirname(file_path).to_s.gsub("app/","")
      unless File.directory?(directory_name)
        FileUtils.mkdir_p(directory_name)
      end
      blocks.each do |block|
        file_name = SecureRandom.urlsafe_base64
        file_base_name = File.basename(file_path,".erb").gsub(".html","")
        File.open("#{directory_name}/_#{file_base_name}_#{file_name}.html.erb", 'w') do |f|
          f.write block.join
        end
        cache_block_info[:cache_block_files].merge!({
          block_id: file_name,
          file_name: "#{directory_name}/_#{file_base_name}_#{file_name}",
          input: {}
        })
      end
    end
    cache_block_info if blocks.present?
  end

end