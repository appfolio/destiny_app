class ApplicationController < ActionController::Base
  include AfRails::Controllers::SslRequirement
  ssl_required :all

  before_filter :authenticate_user!
  after_filter :discard_flash_if_xhr

  protect_from_forgery

  protected

  def reset_db seeds_file="db/seeds.rb"
    Chest.delete_all
    Item.delete_all
    KeyCard.delete_all
    load File.join(Rails.root, seeds_file)
  end

  def set_table_name
    if params[:controller] == "challenges" && current_user.tables_prefix
      Chest.table_name = "#{current_user.tables_prefix}_chests"
      Item.table_name = "#{current_user.tables_prefix}_items"
      KeyCard.table_name = "#{current_user.tables_prefix}_key_cards"
    else
      Chest.table_name = "chests"
      Item.table_name = "items"
      KeyCard.table_name = "key_cards"
    end
  end

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end
end
