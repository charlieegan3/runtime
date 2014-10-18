class Runner < ActiveRecord::Base
  has_many :runs

  def basic_similarity(runner)
    age_similarity = 100 - (self.age - runner.age).abs.to_f * 2 #2x to exaggerate
    (self.gender == runner.gender)? gender_similarity = 100 : gender_similarity = 0
    fitness_similarity = 100 - (self.fitness - runner.fitness).abs * 20

    [age_similarity, gender_similarity, fitness_similarity].inject(:+).to_f / 3
  end

  def run_similarity(runner)
    (runner.runs.pluck(:distance) & runs.pluck(:distance)).size
  end

  def self.estimate(query_runner)
    scored_runs = []
    runners = Run.where(distance: query_runner.query_distance).collect {|r| r.runner }
    runners.reject! {|runner| query_runner == runner } #sometimes happens
    runners.each do |runner|
      basic_similarity = runner.basic_similarity(query_runner)
      if basic_similarity > 90
        related_run = runner.runs.where(distance: query_runner.query_distance).first
        scored_runs << [related_run.time_in_seconds, (basic_similarity * runner.run_similarity(query_runner)).round]
      end
    end

    multiplier = scored_runs.map { |pair| pair[1] }.inject(:+)
    estimate = scored_runs.map { |pair| pair.inject(:*) }.inject(:+) / multiplier
    certainty = scored_runs.map { |pair| pair[0] }.standard_deviation

    [estimate, certainty]
  end
end
