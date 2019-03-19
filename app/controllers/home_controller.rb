class HomeController < ApplicationController
  def index
    if $current_conversation
      $current_conversation = nil
    end
  end
end
