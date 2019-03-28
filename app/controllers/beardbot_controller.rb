class BeardbotController < ActionController::Base
  protect_from_forgery with: :exception

  def chat
    fallbacks = ["Sorry, I don't know enough to respond to that.","Sorry, I'm not really sure about that.","Hmm, that's not familiar to me.","I don't think most dwarves know about that."]
    accessToken = ENV['ACCESS_TOKEN'];
		baseUrl = "https://api.api.ai/v1/";

    require 'net/http'
    require 'json'
    begin
        uri = URI(baseUrl + "query?v=20190101")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json',
          'Authorization' => "Bearer " + accessToken})
        req.body = {"query" => params[:query], "lang" => "en", "sessionId" => (1+rand(9998)).to_s}.to_json
        puts req.to_s #debug
        res = http.request(req)
        puts res.to_s #debug
        reaction = JSON.parse(res.body)
        puts reaction.to_s #debug
        render json: { response: reaction.present? ? reaction["result"]["speech"] : fallbacks.sample }
    rescue => e
        puts "failed #{e}"
    end
  end
end
