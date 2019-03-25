class AdminController < ApplicationController

  def show
    if !current_user || !current_user.is_admin
      redirect_to root_path
    else
      @all_users = User.all

      @ytd_signups = User.count
      @ytd_visits = User.sum(:login_count)
      @ytd_chats = Conversation.count

      con = Conversation.all
      total = 0
      con.each do |c| #want to find a better way to do this, sqlite in dev and postgresql in prod makes this difficult
        total += c.end_time - c.start_time
      end
      ytd_avg = total / @ytd_chats
      @ytd_avg_length = "%s : %s : %s" % [(ytd_avg / 3600).round.to_s.rjust(2, '0'), (ytd_avg / 60).round.to_s.rjust(2, '0'), (ytd_avg % 60).round.to_s.rjust(2, '0')]

    end
  end

  def view_user
    if !current_user || !current_user.is_admin
      redirect_to root_path
    else
      @user = User.find(params[:id])
    end
  end

  def lock_user
    if !current_user || !current_user.is_admin
      redirect_to root_path
    else
      @user = User.find(params[:id])

      @user.active = false
      @user.approved = false
      @user.persistence_token = ''
      @user.save

      redirect_back(fallback_location: root_path)
    end
  end

end
