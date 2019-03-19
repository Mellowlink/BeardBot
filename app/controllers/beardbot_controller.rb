class BeardbotController < ActionController::Base
  protect_from_forgery with: :exception

  def chat
    fallbacks = ["Sorry, I don't know enough to respond to that.","Sorry, I'm not really sure about that.","Hmm, that's not familiar to me.","I don't think most dwarves know about that."]
    reaction = BEARDBOT.get_reaction(params[:query])
    render json: { response: reaction.present? ? reaction : fallbacks.sample }
  end
end
