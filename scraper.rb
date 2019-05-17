# require 'scraperwiki'
require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open("https://clutch.co/agencies/branding"))
companies = {}

page.css('.provider-row').map do |element|
  company_name =  element.css('.field-content').children.text
  company_info = {}

  company_info['employees'] = element.css('span.employees').text

  reviews = Nokogiri::HTML(open(element.css('a').first.attributes['href'].text))
  reviews_text = []

  reviews.css('.views-row').map do |review| 
    reviews_text << review.css('p')[0].text
    company_info['reviews'] = reviews_text
  end

  companies[company_name] = company_info
end

puts companies

# We have not decided yet how to save changes
# Either into a sqlite or CSV file
# ScraperWiki.save_sqlite()
