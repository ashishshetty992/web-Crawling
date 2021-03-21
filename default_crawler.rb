class DefaultCrawler
	attr_accessor :url
	
	def initialize(url)
		@url = url
	end

	def send_data 
		data = get_html_content(@url)
	end

	private
	def get_html_content(url)
		doc = Nokogiri::HTML(URI.open(url))
	end
end