class ChallengesController < ApplicationController
  before_action :set_table_name

  def index
  end

  def start
    redirect_to :index unless challenges_are_setup
  end

  def haystack_sql
    input = params[:column]
    begin
      raise "You can't directly access the items table." if input.include? "items"
      query = Chest.where(input)
      result = query.to_a
      @sql = last_sql
      render partial: "references/query_result", object: result
    rescue => e
      @error = e
      @sql = last_sql
      render partial: "references/query_error"
    end
  end

  def setup_challenge_environment
    @user = current_user

    if @user.tables_prefix
      response_hash = {
        result: :Failure,
        description: "Your environment is already set up."
      }

      render text: response_hash.to_json
    else
      tables_prefix = SecureRandom.uuid.gsub('-','').upcase

      @user.tables_prefix = tables_prefix

      generate_challenge_tables tables_prefix

      @user.save

      response_hash = {
        result: :Success,
        description: "User, your journey starts here: #{tables_prefix}"
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
        drop_table "#{tables_prefix}_key_cards"
      end

      @user.tables_prefix = nil
      @user.save

      response_hash = {
        result: :Success,
        description: "You have ended your journey!"
      }

      render text: response_hash.to_json
    else
      response_hash = {
        result: :Failure,
        description: "You haven't started a challenge yet."
      }

      render text: response_hash.to_json
    end
  end

  private

  def challenges_are_setup
    current_user.tables_prefix.present?
  end

  def generate_challenge_tables tables_prefix
    ActiveRecord::Schema.define do
      create_table "#{tables_prefix}_chests" do |t|
        t.string :size
        t.string :color
        t.string :key_slot

        t.timestamps
      end
      create_table "#{tables_prefix}_items" do |t|
        t.string :name
        t.string :description
        t.string :token
        t.belongs_to :chest, index: true, foreign_key: true

        t.timestamps
      end
      create_table "#{tables_prefix}_key_cards" do |t|
        t.string :blade

        t.timestamps
      end
    end

    set_table_name

    reset_db "db/challenge_seeds.rb"
  end
end
