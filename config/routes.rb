def routes
  Rack::Builder.new do
    
    # Middleware
    use Rack::Session::Cookie
    use Rack::ShowExceptions
    use Rack::CommonLogger
    
    routes = Usher::Interface.for(:rack) do
      get('/').to(HomeController)
      get('/start').to(StartController)
    end
    
    file_server = Rack::File.new(File.join(File.dirname(__FILE__), '../public/'))
    
    run Rack::Cascade.new([routes, file_server])
    
  end
end