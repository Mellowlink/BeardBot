class MessagesController < ApplicationController

  def create
    if current_conversation != nil
      @conversation = current_conversation
      @conversation.end_time = Time.now.utc
      @conversation.save
      @conversation.messages.create(message_params)
    end
  end

  private
  def message_params
    params.permit(:text, :is_beardbot, :conversation_id)
  end
end
