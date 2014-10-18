require_relative '../../config/environment'

ages = (14..70).to_a
genders = ['male', 'male', 'female', 'female', 'other']
fitnesses = (1..5).to_a
distances = [3, 5, 10, 21]

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
