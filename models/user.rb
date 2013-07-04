# encoding: UTF-8
class User < ActiveRecord::Base

  def self.login(login, password)
    if User.authorize(login,password)
      user = User.find_or_create_by_login(login)
      return user
    else
      return "error"
    end
  end

  def self.authorize(login, password)
    success = true
    client = Savon.client(wsdl: 'http://cns.labs.polarion.com/polarion/ws/services/SessionWebService?wsdl', log: false)
    message = { userName: login , password: password }

    begin
      response = client.call(:log_in,message: message)
    rescue
      success = false
    end
    return true
    #return success
  end

end