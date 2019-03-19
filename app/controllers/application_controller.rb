class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user, :current_conversation

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def current_conversation
      if defined?(@current_conversation)
        return @current_conversation
      else
        @current_conversation = Conversation.new
        @current_conversation.start_time = Time.now.utc
        if current_user
          @current_conversation.user_id = current_user.id
        end
      end
    end

  protected
    def handle_unverified_request
      # raise an exception
      fail ActionController::InvalidAuthenticityToken
      # or destroy session, redirect
      if current_user_session
        current_user_session.destroy
      end
      redirect_to root_url
    end
end
