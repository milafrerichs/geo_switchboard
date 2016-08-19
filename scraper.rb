require 'scraperwiki'
require 'mechanize'
require 'open-uri'
content = Nokogiri::XML(open("https://geo.switchboardhq.com/"))
items = content.xpath('//item')
items.each do |item|
  link = item.xpath('link').text
  sub_page = Nokogiri::HTML(open(link))
  type = sub_page.xpath('//*[@id="main_post"]/div[1]/div[1]/span').text.strip
  if type == "Jobs"
    description = item.xpath('description').text
    title = item.xpath('title').text
    date = item.xpath('pubDate').text
    ScraperWiki.save_sqlite(["title", "date"], {"title" => title, "date"=> date, "description"=> description})
  end
end
