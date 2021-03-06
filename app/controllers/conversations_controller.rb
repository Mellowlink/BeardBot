class ConversationsController < ApplicationController
  def show
    if !current_user
      redirect_to root_path
    else
      @conversations = current_user.conversations.order('created_at DESC')
    end
  end
end
