class ProcessLargeFiles
	attr_accessor :doc
	
	def initialize(doc)
		@doc = doc
	end

	def get_image
		process_image(@doc)
	end

	private

	def process_image(doc)
		doc.css('img').each do |img|
			p img.attributes['src'].value rescue img.attributes['src'].nil?
		end
	end

	def process_videos
		# get videos
		# process_videos
	end

	def process_other_files
		#process
	end

	# based on the extension we can call the methods
end
