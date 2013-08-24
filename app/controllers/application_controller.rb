class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def init_agent
  	agent = Mechanize.new{|a| a.history.max_size = 10}
  	agent.user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5'
  	agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
  	agent
  end  

end