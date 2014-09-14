class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect(@user, event: :authentication)
     	flash[:success] = "Welcome, #{@user.name}!" if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private
  def from_omniauth(auth)
    User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name 
	    user.image = auth.info.image
	  end
	end
end