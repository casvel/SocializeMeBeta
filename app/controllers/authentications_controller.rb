class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]

    authentication = Authentication.where(
        provider: auth['provider'],
        uid: auth['uid'],
        token: auth['credentials']['token'],
        secret: auth['credentials']['secret']).first

    if authentication
      flash[:notice] = "Signed in succesfully."
      sign_in_and_redirect(:usuario, authentication.user)
    else
      user = User.new
      user.apply_omniauth(auth)
      session[:auth] = auth.except('extra')

      flash[:notice] = "Authentication succesfully."
      redirect_to new_user_registration_url
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
