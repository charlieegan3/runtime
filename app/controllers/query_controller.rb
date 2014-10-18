class QueryController < ApplicationController

  def index
    @query = Run.new
  end

  def submit
    runner = Runner.new(age: params[:age], gender: params[:gender].downcase, fitness: params[:fitness], query_distance: params[:query_distance])
    runner.save!

    params['run'].each do |run|
      run = Run.new(runner: runner, distance: run[1]['distance'].to_i, hours: run[1]['hours'].to_i, minutes: run[1]['minutes'].to_i, seconds: run[1]['seconds'].to_i)
      run.save!
    end

    @estimate = Runner.estimate(runner)
  end

end
