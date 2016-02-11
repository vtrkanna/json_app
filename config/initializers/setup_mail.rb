ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
    :address              => "127.0.0.1",
    :port                 => 25,
    :domain               => "vtrkanna",
    # :user_name            => "vtrkanna",
    # :password             => "vtrkanna",
    # :authentication       => "login",
    :enable_starttls_auto => false

}