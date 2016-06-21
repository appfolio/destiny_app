class CsrfMailer < ActionMailer::Base

  def csrf_email(user, request, csrf_token)
    @user = user
    @url = "#{request.protocol}#{request.host}:#{request.port}"
    @csrf_token = csrf_token
    mail to: @user.email, subject: "Email with the CSRF 'Attack'"
  end
end
