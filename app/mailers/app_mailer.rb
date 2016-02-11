class AppMailer < ActionMailer::Base
  default :from => "noreply@vtrkanna.com"
  def invite_user(user, sub)
    @user = User.find user.id
    mail(to: user.email, subject: sub, from: "vtrkanna@yahoo.com")
  end

  def sign_up_email(user, sub)
    @user = Contact.find_by_email user.email
    mail(to: user.email, subject: sub)
  end

end
