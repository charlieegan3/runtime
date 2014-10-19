require_relative '../../config/environment'

def time(time)
  time.gsub!(/\..*/, "")
  time = "00:#{time}" if time.length < 4
  time = "00:#{time}" if time.length < 7
  time.split(':').map { |x| x.to_i }
end

File.open(Rails.root.join("lib/tasks/times.txt").to_s, 'r').each do |line|
  row = line.split(',')
  runner = Runner.create(gender: row[1], age: row[2])

  times = time(row[3])
  Run.create(runner: runner, distance: 42.1949, hours: times[0], minutes: times[1], seconds: times[2])
  times = time(row[4])
  Run.create(runner: runner, distance: 42.1949, hours: times[0], minutes: times[1], seconds: times[2])
end