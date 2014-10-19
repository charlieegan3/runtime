module ApplicationHelper
  def formatted_time_from_seconds(time, colon = true)
    string = Time.at(time).utc.strftime("%H:%M:%S")
    if colon == false
      string
    else
      string.split(':').join('<span class="colon">:</span>')
    end
  end
end
