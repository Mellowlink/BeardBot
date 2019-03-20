class ConversationsController < ApplicationController
  def show
    @conversations = current_user.conversations.reverse
  end
end
