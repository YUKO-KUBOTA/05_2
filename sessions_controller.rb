# class SessionsController < ApplicationController
#   def new
#   end
# end

class SessionsController < ApplicationController
  def new
  end

  def create
    # user = User.find_by(email: params[:session][:email])
    # if user && user.authenticate(params[:session][:password])
    
    # user = User.find_by(email: email_params[:email])
    user = User.find_by(email: session_params[:email])
    logger.error("authenticate: #{user.authenticate(session_params[:password])}")
    if user && user.authenticate(session_params[:password])
#上記Rails 05　課題:SessionsControllerにストロングパラメーターを実装

      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  # def email_params
  #   params.require(:session).permit(:email)
  # end
  
  def session_params
    # logger.info("params: #{params}")
    params.require(:session).permit(:email, :password)
  end

  # def password_params
  #   params.require(:session).permit(:password)
  # end
#上記Rails 05　課題:SessionsControllerにストロングパラメーターを実装

  private
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
