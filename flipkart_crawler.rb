class FlipkartCrawler
	# domain specific logics
	def self.crawler(doc)
		p doc.title
		ProcessLargeFiles.new(doc).get_image
	end
end