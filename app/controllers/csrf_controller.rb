class CsrfController < ApplicationController
  def index
  end

  def send_csrf_email
    current_user.csrf_email_read = false
    current_user.save!
    csrf_token = session[:_csrf_token]
    CsrfMailer.csrf_email(current_user, request, csrf_token).deliver
    render nothing: true
  end

  # Gets hit from the csrf email
  def target
    current_user.csrf_email_read = true
    current_user.save!
    render nothing: true
  end

  # Tells user if the csrf email has hit the target
  def check
    read = current_user.csrf_email_read
    json = { read: read }
    render text: json.to_json
  end
end
