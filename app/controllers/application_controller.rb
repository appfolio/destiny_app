class ApplicationController < ActionController::Base
  include AfRails::Controllers::SslRequirement
  ssl_required :all

  before_filter :authenticate_user!
  before_filter :set_current_user
  before_filter :set_time_zone
  after_filter :discard_flash_if_xhr

  protect_from_forgery

  def af_decl_auth_has_privilege
    params.require(:model)
    params.require(:privilege)

    model = params[:model]
    if !model.end_with? 's'
      model += 's'
    end
    model     = model
    privilege = params[:privilege]
    result    = permitted_to?(privilege.to_sym, model.to_sym)
    respond_to do |format|
      format.json { render :json => { :model => model, :privilege => privilege, :result => result } }
      format.xml { render :json => { :model => model, :privilege => privilege, :result => result } }
    end
  end

  protected

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

  def set_current_user
    Authorization.current_user = current_user
  end

  def set_time_zone
    Time.zone = 'America/Los_Angeles'
  end

  def http_authenticate_private
    authenticate_or_request_with_http_basic do |username, password|
      username == Setting.credentials.username && password == Setting.credentials.password
    end
  end

  def permission_denied
    msg = "Sorry, but you are not authorized for that content."
    respond_to do |format|
      format.json { render :json => { :error => msg, :status => 403 } }
      format.xml { render :xml => { :error => msg, status: 403 } }
      format.html {
        flash[:alert] = msg
        redirect_to (request.referrer || root_path)
      }
    end
  end

end
