class ApplicationController < ActionController::Base
  include AfRails::Controllers::SslRequirement
  ssl_required :all

  before_filter :authenticate_user!
  after_filter :discard_flash_if_xhr

  protect_from_forgery

  protected

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end
end
