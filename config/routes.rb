def app_routes
  Rack::Builder.new do
    use Rack::Session::Cookie
    
    routes = Usher::Interface.for(:rack) do
      get('/').to(HomeController)
    end
    
    run Rack::Cascade.new([routes])
    
  end
end