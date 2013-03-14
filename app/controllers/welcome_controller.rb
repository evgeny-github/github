class WelcomeController < ApplicationController
  def index
    @title = 'start page'
  end

  def show
  end

  def signin
    redirect_to "#{users_path}/sign_in"
  end

  def signout
    sign_out @user
    #~ redirect_to :root
    redirect_to "#{users_path}/sign_in"
  end
end
