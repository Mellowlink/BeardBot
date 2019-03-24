class MessagesController < ApplicationController

  def create
    if $current_conversation == nil
      $current_conversation = Conversation.new
      $current_conversation.start_time = Time.now.utc
      if current_user
        $current_conversation.user_id = current_user.id
      end
    end
      $current_conversation.end_time = Time.now.utc
      $current_conversation.save
      $current_conversation.messages.create(message_params)
  end

  def show
    convo = Conversation.find(message_params[:conversation_id]).messages
    render json: { response: convo.present? ? convo : "This is weird, we didn't find anything" }
  end

  private
  def message_params
    params.permit(:text, :is_beardbot, :conversation_id)
  end
end
