class QueryController < ApplicationController

  def index
    @query = Run.new
  end

  def submit
  end

end
