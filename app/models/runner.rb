class Runner < ActiveRecord::Base
  has_many :runs

  def basic_similarity(runner)
    age_similarity = 100 - (self.age - runner.age).abs.to_f * 2 #2x to exaggerate
    (self.gender == runner.gender)? gender_similarity = 100 : gender_similarity = 0
    fitness_similarity = 100 - (self.fitness - runner.fitness).abs * 20 if runner.fitness && self.fitness

    [age_similarity, gender_similarity, fitness_similarity].compact.inject(:+).to_f / 3
  end

  def run_similarity(runner)
    (runner.runs.pluck(:distance) & runs.pluck(:distance)).size
  end

  def self.estimate(query_runner)
    scores = {related: [], ratio: []} #more at a later date

    scored_runs = scored_runs(query_runner)

    if scored_runs.size > 0
      multiplier = scored_runs.map { |pair| pair[1] }.inject(:+)
      estimate = scored_runs.map { |pair| pair.inject(:*) }.inject(:+) / multiplier
      certainty = scored_runs.map { |pair| pair[0] }.standard_deviation

      scores[:related] = [estimate, certainty, scored_runs.size]
    end

    times = []
    query_runner.runs.each do |run|
      ratio = Ratio.where(distance1: distance_range(run.distance), distance2: distance_range(query_runner.query_distance)).first
      times << [ratio.multiplier * run.time_in_seconds, ratio.certainty] if ratio.nil? == false
    end
    times.reject! {|x| x[1].nil?}
    scores[:ratio] = [
      times.map{ |x| x[0] }.inject(:+) / times.size,
      times.map{ |x| x[1] }.inject(:+) / times.size,
      times.size
    ]

    best_difference = 10000
    best_run = nil

    query_runner.runs.each do |run|
      if (run.distance - query_runner.query_distance).abs < best_difference
        best_difference = (run.distance - query_runner.query_distance).abs
        best_run = run
      end
    end

    scores[:riegel] = [best_run.time_in_seconds * (query_runner.query_distance.to_f/best_run.distance) * 1.06, best_run]

    scores
  end

  private
    def self.scored_runs(query_runner)
      scored_runs = []
      runners = Run.where(distance: distance_range(query_runner.query_distance)).collect {|r| r.runner }
      runners.reject! {|runner| query_runner == runner } #sometimes happens
      runners.each do |runner|
        basic_similarity = runner.basic_similarity(query_runner)
        if basic_similarity > 50 #is this cutting out too much? it was at 90
          related_run = runner.runs.where(distance: distance_range(query_runner.query_distance)).first
          scored_runs << [related_run.time_in_seconds, (basic_similarity * runner.run_similarity(query_runner)).round + 1]
        end
      end
      scored_runs
    end

    def self.distance_range(distance, percentage = 3)
      percentage = percentage.to_f / 100
      offset = distance * percentage
      (distance - offset)..(distance + offset)
    end
end
