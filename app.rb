# encoding: utf-8

require 'rubygems'
require 'bundler'
Bundler.require

class App < Sinatra::Base

  register Sinatra::WeiXinRobot

  configure do
    enable  :logging
    set     :weixin_token, ""
    set     :weixin_uri,   "http://yaoyaohuahuapangpang.cloudfoundry.com/"
  end

  get "#{settings.weixin_path}" do
    "#{params[:echostr]}"
  end

  post "#{settings.weixin_path}" do
    if generate_signature == params[:signature]
      msg = message_receiver(request.body)
      weixin.sender(:msg_type => "text") do |msg|
        msg.content = "Hello"
      end
    end
  end

end
