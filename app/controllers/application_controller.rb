class ApplicationController < Cramp::Controller::Action
  include ApplicationHelper
  
  @@counter = 0
  @@games   = {}
  
end

class WebSocketApplicationController < Cramp::Controller::Websocket
  include ApplicationHelper
end