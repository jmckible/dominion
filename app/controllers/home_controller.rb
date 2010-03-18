class HomeController < ApplicationController
  
  def start
    render Tilt::HamlTemplate.new('app/views/index.haml').render
    finish
  end
  
end