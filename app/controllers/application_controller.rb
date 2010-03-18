class ApplicationController < Cramp::Controller::Action
  include ApplicationHelper
  
  @@counter = 0
  @@sockets = {}
  @@pids    = []
  
  def self.reap
    @@pids.each do |pid| 
      puts "Killing game #{pid}"
      Process.kill 'HUP', pid
    end
  end
  
end

class WebSocketApplicationController < Cramp::Controller::Websocket
  include ApplicationHelper
end