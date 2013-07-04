require './pms'
run Sinatra::Application
use Rack::Session::Cookie, :key => 'my_app_key', :path => '/', :expire_after => 13333, :secret => 'secret_stuff'