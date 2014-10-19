require 'nokogiri'
require 'open-uri'
require 'pry'

for i in 1..35
  url = "http://www.invernesshalfmarathon.co.uk/result/38/2014-half-marathon-results/?epage=#{i}"
#  url = "http://www.lochnessmarathon.com/result/72/2014-baxters-loch-ness-marathon/?epage=#{i}"
  doc = Nokogiri::HTML(open(url))
  doc.css('table tr').each do |tr|
    row = tr.css('td').map {|x| x.text}

  
    unless row == []
      if row[6].include? "M"
        gender = 'male'  
      else
        gender = 'female'
      end
      
      age = row[6].match(/[0-9]+/).to_s
      
      if age == ""
        age = "30"
      end
      
      string = [row[2], row[3], row[4], gender, age].join(',')
      puts string if string.length > 10
    end
  end
end
