class PagesController < ApplicationController
  def front
    respond_to do |format|
      format.json
      format.html
    end
  end

  # GET /user/:user
  def user
    @user = params[:user]
    if User.find_by_user(@user)
      user = User.find_by_user(@user)
      user.count += 1
      user.save
    else
      User.create!(user: @user, count: 1)
    end

    user = @user

    if @user.to_i == 0
      user = Steam.steamid_from_vanity @user
    else
      # they are specifying a steamid
      user = @user
    end
    @steamid = user
  end
end
