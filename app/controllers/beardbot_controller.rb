class BeardbotController < ActionController::Base
  protect_from_forgery with: :exception

  def chat
    reaction = BEARDBOT.get_reaction(params[:query])
    render json: { response: reaction.present? ? reaction : 'Sorry, I don\'t know enough to respond to that.' }
  end
end
