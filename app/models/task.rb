class Task < ActiveRecord::Base
  belongs_to :project
  validates :text, presence: true
  
  def time_diff(deadline_time, now_time)
  seconds_diff = (deadline_time - now_time).to_i
  res = ""
  if seconds_diff < 0
    res += "-"
    seconds_diff = seconds_diff.abs
  end

  hours = seconds_diff / 3600
  seconds_diff -= hours * 3600

  minutes = seconds_diff / 60
  seconds_diff -= minutes * 60

  seconds = seconds_diff
  
  res+="#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
end
end
