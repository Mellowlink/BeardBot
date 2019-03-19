class ConversationsController < ApplicationController

  def create

    if current_user
      #@user = User.find(current_user.id)
      #@user.conversations.create(conversation_params)
      @conversation = current_user.conversations.create()
      @conversation.start_time = Time.now.utc
      #@conversation.save
    else
      @conversation = Conversation.new()
      @conversation.start_time = Time.now.utc
      #@conversation.save
    end
  end

end
