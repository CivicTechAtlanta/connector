class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    person = person_from_omniauth(request.env["omniauth.auth"])
    user = user_from_omniauth(request.env["omniauth.auth"], person)

    if user.persisted?
      sign_in_and_redirect(user, event: :authentication)
      flash[:success] = "Welcome!" if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:danger] = "We're sorry, but we couldn't log you in."
      redirect_to root_path
    end
  end

  private

  def user_from_omniauth(auth, person)
    User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.person_id = person.id
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
