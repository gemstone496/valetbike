class Trip < ApplicationRecord
  belongs_to :user

  def time
    hour = 3600
    minute = 60
    if end_time.present? && start_time.present?
      diff =  end_time - start_time
        hours = (diff/3600).floor
        minutes = ((diff - hours*hour) / minute).floor
        seconds = (diff - hours*hour - minute*minutes).round
        vars = [hours, minutes, seconds]
    else
      0
    end
  end

  def time_minutes
    hr_min_sec = self.time
    hr = hr_min_sec[0]
    min = hr_min_sec[1]
    sec = hr_min_sec[2]
    record = 60*hr + min + (sec/60).round
  end
end

