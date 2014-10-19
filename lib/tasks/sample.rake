require_relative '../../config/environment'
require 'open-uri'

ages = (14..70).to_a
genders = ['male', 'male', 'female', 'female', 'other']
fitnesses = (1..5).to_a
distances = [3, 5, 10, 21]

def distance(distance)
  distance = Distance.find_by_identifier(distance)
  if distance.nil?
    0
  else
    distance.value
  end
end

def time(time)
  time.gsub!(/\..*/, "")
  time = "00:#{time}" if time.length < 4
  time = "00:#{time}" if time.length < 7
  time.split(':').map { |x| x.to_i }
end

task :scrape do
  Runner.delete_all
  Run.delete_all

  urls = []
  File.open(Rails.root.join("lib/tasks/urls.txt").to_s, 'r').each_line do |line|
    urls << line.strip
  end
  urls.select! {|x| x.include? 'http://www.thepowerof10.info/athletes/profile.aspx?athleteid='}

  count = 0
  urls.each do |url|
    count += 1
    doc = Nokogiri::HTML(open(url))

    gender = doc.css('#ctl00_cphBody_pnlAthleteDetails tr')[3].css('td').last.text.downcase
    age = doc.css('#ctl00_cphBody_pnlAthleteDetails tr')[4].css('td').last.text.match(/[0-9]+/).to_s.to_i

    if (age > 5) and (['male', 'female', 'other'].include? gender)
      events = doc.css('.alternatingrowspanel').first.css('tr').to_a
      events.delete_at(0)

      if events.size > 1
        runner = Runner.create(age: age, gender: gender)

        events.each do |event|
          time = time(event.css('td')[1].text)
          distance = distance(event.css('td').first.text)
          if (distance != 0) && (time.compact == time) && (time.inject(:+) > 0)
            Run.create(distance: distance, runner: runner, seconds: time[2], minutes: time[1], hours: time[0])
          else
            # puts event.css('td').first.text if event.css('td').first.text != "Event"
          end
        end
        puts "#{(count.to_f/urls.size).round(2)} #{url}"
      else
        puts "#{(count.to_f/urls.size).round(2)} USELESS!!!"
      end

      sleep 0.5
    else
      next
    end
  end
end
