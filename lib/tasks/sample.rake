require_relative '../../config/environment'
require 'open-uri'

ages = (14..70).to_a
genders = ['male', 'male', 'female', 'female', 'other']
fitnesses = (1..5).to_a
distances = [3, 5, 10, 21]

def distance(distance)
  if distance == 'parkrun'
    5
  elsif distance == 'HM'
    21.097
  elsif distance == '5000'
    5
  elsif distance == '3000'
    3
  elsif distance == 'Mar'
    42.1949
  elsif distance == '10K'
    10
  elsif distance == '1500'
    1.5
  elsif distance == '10M'
    16.09
  elsif distance == '5M'
    8.05
  elsif distance == '4M'
    6.44
  else
    0
  end
end

def time(time)
  time.gsub!(/\..*/, "")
  time = "00:#{time}" if time.length < 4
  time = "00:#{time}" if time.length < 7
  time.split(':').map { |x| x.to_i }
end

task :generate_samples do
  Runner.delete_all
  Run.delete_all

  100.times do
    runner = Runner.new(age: ages.sample,
      gender: genders.sample,
      fitness: fitnesses.sample,
      query_distance: distances.sample)
    runner.save!

    3.times do
      distance = distances.sample
      Run.new(runner: runner,
        distance: distance,
        seconds: 0,
        minutes: rand(3.0..10.0) * distance,
        hours: 0).save
    end
  end
end

task :scrape, [:url]  => :environment  do |t, args|
  doc = Nokogiri::HTML(open(args.url))

  gender = doc.css('#ctl00_cphBody_pnlAthleteDetails tr')[3].css('td').last.text
  age = doc.css('#ctl00_cphBody_pnlAthleteDetails tr')[4].css('td').last.text

  runner = Runner.create(age: age.match(/[0-9]+/).to_s, gender: gender.downcase)

  events = doc.css('.alternatingrowspanel').first.css('tr').to_a
  events.delete_at(0)
  events.each do |event|
    time = time(event.css('td')[1].text)

    Run.create(distance: distance(event.css('td').first.text), runner: runner, seconds: time[2], minutes: time[1], hours: time[0])
  end

  puts runner
  puts runner.runs
end
