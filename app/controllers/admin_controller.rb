class AdminController < ApplicationController

  def show
    if !current_user || !current_user.is_admin
      redirect_to root_path
    else
      @all_users = User.all

      @ytd_signups = User.count
      @ytd_chats = Conversation.count
      @ytd_msgs = Message.count

      #ytd
      con = Conversation.all
      total = 0
      con.each do |c| #want to find a better way to do this, sqlite in dev and postgresql in prod makes this difficult
        total += c.end_time - c.start_time
      end
      if @ytd_chats > 0
        avg = total / @ytd_chats
        @ytd_avg_length = "%s : %s : %s" % [(avg / 3600).round.to_s.rjust(2, '0'), (avg / 60).round.to_s.rjust(2, '0'), (avg % 60).round.to_s.rjust(2, '0')]
      else
        @ytd_avg_length = "00 : 00 : 00"
      end

      #monthly
      @monthly_map = {}

      #date of the app's deployment, but hard-coding this is a bit stupid. need to set this up as a proper env variable for reusability
      range_m = 6
      range_y = 2018

      while range_y < Time.now.year || range_m <= Time.now.month do
        puts "Current year: %s" % range_y
        puts "Current month: %s" % range_m
        puts '_____'

        con = Conversation.where("created_at >= '%s-%s-01' and created_at <= '%s-%s-31'" % [range_y.to_s, range_m.to_s.rjust(2, '0'), range_y.to_s, range_m.to_s.rjust(2, '0')])
        total = 0
        con.each do |c| #same as ytd above, find a better way
          total += c.end_time - c.start_time
        end
        if con.count > 0
          avg = total / con.count
          avg_length = "%s : %s : %s" % [(avg / 3600).round.to_s.rjust(2, '0'), (avg / 60).round.to_s.rjust(2, '0'), (avg % 60).round.to_s.rjust(2, '0')]
        else
          avg_length = "00 : 00 : 00"
        end

        @monthly_map[range_m.to_s.rjust(2, '0') + "/" + range_y.to_s[2..-1]] = {
          "signups" => User.where("created_at >= '%s-%s-01' and created_at <= '%s-%s-31'" % [range_y.to_s, range_m.to_s.rjust(2, '0'), range_y.to_s, range_m.to_s.rjust(2, '0')]).count.to_s,
          "chats" => con.count.to_s,
          "msgs" => Message.where("created_at >= '%s-%s-01' and created_at <= '%s-%s-31'" % [range_y.to_s, range_m.to_s.rjust(2, '0'), range_y.to_s, range_m.to_s.rjust(2, '0')]).count.to_s,
          "avg_length" => avg_length}

        if range_m == 12
          range_m = 1
          range_y += 1
        else
          range_m += 1
        end
      end

      @monthly_map = @monthly_map.to_a.reverse.to_h
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
