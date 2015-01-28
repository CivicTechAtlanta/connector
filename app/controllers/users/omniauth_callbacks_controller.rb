class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if user.persisted?
      sign_in_and_redirect(user, event: :authentication)
      flash[:success] = "Welcome! Check out our projects and get involved!"
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:danger] = "We're sorry, but we couldn't log you in."
      redirect_to root_path
    end
  rescue OmniAuth::Strategies::Facebook::NoAuthorizationCodeError
    flash[:danger] = "We're sorry, but we couldn't log you in."
    redirect_to root_path
  end

  def google_oauth2
    if user.persisted?
      sign_in_and_redirect(user, event: :authentication)
      flash[:success] = "Welcome! Check out our projects and get involved!"
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      flash[:danger] = "We're sorry, but we couldn't log you in."
      redirect_to root_path
    end
  end

  private

  def person
    person_from_omniauth(request.env["omniauth.auth"])
  end

  def user
    user_from_omniauth(request.env["omniauth.auth"], person)
  end

  def user_from_omniauth(auth, person)
    User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.person = person
    end
  end

  def person_from_omniauth(auth)
    Person.where(email: auth.info.email).first_or_create do |person|
      person.email = auth.info.email
      person.name = auth.info.name
      person.image = auth.info.image
    end
  end
end
