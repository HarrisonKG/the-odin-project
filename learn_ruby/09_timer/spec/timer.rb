
class Timer
  attr_accessor :seconds
  
  def initialize
   @seconds = 0
  end
  
  def time_string
  	seconds = @seconds
   minutes = seconds/60 
   hours = seconds/3600 
   if seconds >=60
   seconds -= minutes*60
   end
   if minutes>=60
   minutes -= hours*60
   end
   time = "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

end