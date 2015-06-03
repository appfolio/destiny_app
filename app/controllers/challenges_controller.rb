class ChallengesController < ApplicationController
  before_action :set_table_name

  def index
  end

  def setup_challenge_environment
    @user = current_user

    if @user.tables_prefix
      response_hash = {
        result: :failure,
        description: "Your environment is already set up.",
        chest_table: Chest.table_name,
        item_table: Item.table_name,
        chests: Chest.all,
        items: Item.all
      }

      render text: response_hash.to_json
    else
      tables_prefix = SecureRandom.uuid.gsub('-','').upcase

      @user.tables_prefix = tables_prefix

      generate_challenge_tables tables_prefix

      @user.save

      response_hash = {
        result: :success,
        tp: tables_prefix
      }

      render text: response_hash.to_json
    end
  end

  def restart
    @user = current_user
    tables_prefix = @user.tables_prefix

    if tables_prefix
      ActiveRecord::Schema.define do
        drop_table "#{tables_prefix}_chests"
        drop_table "#{tables_prefix}_items"
      end

      @user.tables_prefix = nil
      @user.save

      response_hash = {
        result: :success,
        tp: @user.tables_prefix
      }

      render text: response_hash.to_json
    else
      response_hash = {
        result: :failure,
        description: "You haven't started a challenge yet.",
        tp: @user.tables_prefix
      }

      render text: response_hash.to_json
    end
  end

  private

  def generate_challenge_tables tables_prefix
    ActiveRecord::Schema.define do
      create_table "#{tables_prefix}_chests" do |t|
        t.string :size
        t.string :color

        t.timestamps
      end
      create_table "#{tables_prefix}_items" do |t|
        t.string :name
        t.string :description
        t.string :token
        t.belongs_to :chest, index: true, foreign_key: true

        t.timestamps
      end
    end

    set_table_name

    reset_db "db/challenge_seeds.rb"
  end
end
