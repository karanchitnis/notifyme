class Trial < ActiveRecord::Base
  
  def set_random_string
  	SecureRandom.hex
  end
end
