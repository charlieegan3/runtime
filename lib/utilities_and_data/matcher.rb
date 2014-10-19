names = {}

File.open("full.txt", 'r').each do |line|
  runner = line.split(',')
  name = runner[0..1].join(' ')
#  half = runner[2]
  full = runner[3].strip
  
  names[name] = [[runner[4], runner[5].strip, full]]
end

File.open("half.txt", 'r').each do |line|
  runner = line.split(',')
  name = runner[0..1].join(' ')
  half = runner[2].strip

  if names[name].nil? == false
    names[name] << [runner[3], runner[4], half]
  end
end


names = names.to_a
names.select! {|x| x[1].size > 1}

names.reject! {|x| x[1][0][1].strip != x[1][1][1].strip }
names.map {|x| 
  puts [x[0], x[1][0][0], x[1][0][1], x[1][0][2], x[1][1][2]].join(',')
}


