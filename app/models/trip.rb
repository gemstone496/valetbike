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
end

