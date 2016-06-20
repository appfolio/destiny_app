class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  after_filter :discard_flash_if_xhr

  protect_from_forgery

  protected

  def registration_allowed?
    config.allow_registration
  end

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
      #for references controllers
      #
      id = current_user.id
      unless ActiveRecord::Base.connection.table_exists? "#{id}_reference_letters"
        ActiveRecord::Schema.define do
          create_table "#{id}_reference_letters" do |t|
            t.string :content

            t.timestamps
          end
        end
      end

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
