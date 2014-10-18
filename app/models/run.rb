class Run < ActiveRecord::Base
  belongs_to :runner

  def time_in_seconds
    hours * 60 * 60 + minutes * 60 + seconds
  end
end
