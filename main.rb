require 'yaml'
require 'pry'
require 'adomain'
require 'nokogiri'
require 'open-uri'
require 'json'
require './load_domain_specific_crawlers'
require './public_services'

class WebCrawler
	def method_missing method, *args, &block

		return super method, *args, &block unless method.to_s =~ /^webcrawler_\w+/

		self.class.send(:define_method, method) do |args = nil|
			p "writing " + method.to_s.gsub(/^webcrawler_/, '').to_s
			@class_name = method.to_s.gsub(/^webcrawler_/, '')
			dynamic_class_name = @class_name.to_str.upcase[0]+@class_name.slice(1..-1)+'Crawler'
			doc = DefaultCrawler.new(*args).send_data
			eval(dynamic_class_name).crawler(doc)
		end

		self.send method, *args, &block

	end
end

# ex_input : "https://www.flipkart.com/zigma-tiktik-quiet-portable-300-mm-ultra-high-speed-3-blade-table-fan/p/itm8ffecdf05e366?pid=FANFR8YZTYKG4PHY&lid=LSTFANFR8YZTYKG4PHYM53GSJ&marketplace=FLIPKART&store=j9e%2Fabm%2Flbz&srno=b_1_1&otracker=hp_omu_Season%2527s%2Btop%2Bpicks_3_8.dealCard.OMU_2U0F9EAN0GMD_6&otracker1=hp_omu_WHITELISTED_neon%2Fmerchandising_Season%2527s%2Btop%2Bpicks_NA_dealCard_cc_3_NA_view-all_6&fm=neon%2Fmerchandising&iid=3a564110-eb88-40aa-85a5-44e4188c13b6.FANFR8YZTYKG4PHY.SEARCH&ppt=hp&ppn=homepage&ssid=d7xwmri5ds0000001616322091264","https://hello.com/en/inspiration/index.html"

def get_input
	available_domains = YAML.load_file('domain.yml')
	puts "Please enter url seperated by comma(',')"
	response = gets.chomp
	input = response.split(',').map(&:strip)
	wc = WebCrawler.new

	input.each do |url|
	@url = JSON.parse(url)
		if available_domains['domain'].include?(Adomain[@url])
			method_name = Adomain[@url].split('.')[0]
			wc.send 'webcrawler_'+method_name, @url
		else
			p "currently we do not support the following domain name"
		end
	end

end

get_input



