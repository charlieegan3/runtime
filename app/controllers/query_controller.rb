class QueryController < ApplicationController

  def index
    @query = Run.new
  end

end