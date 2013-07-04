# encoding: UTF-8
require 'sinatra'
require 'savon'
require "awesome_print"
require "sinatra/activerecord"

set :database, "sqlite3:///pms.db"

require_relative "models/user"
require_relative "helpers/session"
require_relative "helpers/application"

enable :sessions

get "/" do
  authorized?
  #redirect "/settings" if current_user.setup == false
  erb :index
end

get "/login" do
  erb :login, :layout => false
end

post "/login" do
  user = User.login(params[:login], params[:password])
  if user.class == User
    authorize!(user)
    redirect "/"
  else
    redirect "/login?error=#{user}"
  end
end

get "/logout" do
  session.clear
  redirect "/login?info=logout"
end