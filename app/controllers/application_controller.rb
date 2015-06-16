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
    if (params[:controller] == "challenges" ||
        params[:controller] == "castle") && current_user.tables_prefix
      Chest.table_name = "#{current_user.tables_prefix}_chests"
      Item.table_name = "#{current_user.tables_prefix}_items"
      KeyCard.table_name = "#{current_user.tables_prefix}_key_cards"
      Letter.table_name = "#{current_user.tables_prefix}_letters"
    else
      #for references controller
      Chest.table_name = "chests"
      Item.table_name = "items"
      KeyCard.table_name = "key_cards"
      Letter.table_name = "#{current_user.id}_reference_letters"
    end
  end

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

  def last_sql
    sql = $last_sql
    $last_sql = nil
    sql
  end
end
