class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:pre_2fa_auth_user_id] = @user.id
      Authy::API.request_sms(id: @user.authy_id)
      redirect_to two_factor_sessions_path
    else
      @user ||= User.new(email: params[:email])
      render :new
    end
  end

  def two_factor
    return redirect_to new_session_path unless session[:pre_2fa_auth_user_id]
  end

  def verify
    @user = User.find(session[:pre_2fa_auth_user_id])
    token = Authy::API.verify(id: @user.authy_id, token: params[:token])
    if token.ok?
      session[:user_id] = @user.id
      session[:pre_2fa_auth_user_id] = nil
      redirect_to @user
    else
      render :two_factor
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
