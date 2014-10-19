require_relative '../../config/environment'
require 'open-uri'

ages = (14..70).to_a
genders = ['male', 'male', 'female', 'female', 'other']
fitnesses = (1..5).to_a
distances = [3, 5, 10, 21]

def distance(distance)
  distance = Distance.find_by_identifier(distance)
  distance = 0  if distance.nil?
  distance
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

  [
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=228323',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=522763',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=42875',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=299903',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=140527',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=111486',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=185612',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=299904',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=352083',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=508711',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=41986',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=257261',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=615616',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=80587',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=83819',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=6231',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=49920',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=63349',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=38262',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=240070',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=307433',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=307431',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=525172',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=273426',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=307430',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=120786',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=307428',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=273427',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=11039',
    'http://www.thepowerof10.info/athletes/profile.aspx?athleteid=602135'
  ].each do |url|
    doc = Nokogiri::HTML(open(url))

    gender = doc.css('#ctl00_cphBody_pnlAthleteDetails tr')[3].css('td').last.text
    age = doc.css('#ctl00_cphBody_pnlAthleteDetails tr')[4].css('td').last.text

    if age and gender
      runner = Runner.create(age: age.match(/[0-9]+/).to_s, gender: gender.downcase)

      events = doc.css('.alternatingrowspanel').first.css('tr').to_a
      events.delete_at(0)
      events.each do |event|
        time = time(event.css('td')[1].text)
        distance = distance(event.css('td').first.text)
        if distance != 0
          Run.create(distance: distance, runner: runner, seconds: time[2], minutes: time[1], hours: time[0])
        else
          puts event.css('td').first.text
        end
      end

      sleep 0.5
    else
      next
    end
  end
end
