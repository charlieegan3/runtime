# utility to build a list of links given a saved search on power of ten
require 'nokogiri'

f = File.open("a.html")

doc = Nokogiri::HTML(open(f))

doc.css('table a').each do |link|
  if (link['href'].include? "profile.aspx?athleteid=") && (link['href'].length < 30)
    puts "http://www.thepowerof10.info/athletes/profile.aspx?athleteid=" + link['href'].match(/[0-9]+\z/).to_s
  end
end

