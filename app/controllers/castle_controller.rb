class CastleController < ApplicationController
  before_action :set_table_name
  layout "castle"

  def gate
    gate = Gate.where(tables_prefix: current_user.tables_prefix)

    unless gate.present?
      Gate.create({is_locked: true, tables_prefix: current_user.tables_prefix})
    end
  end

  def deliver_letter
    #Example of 'persuasive' letter
    #<script> jQuery.ajax({type:"POST",url:"open_gate"}) </script>
    input = params[:column]

    begin
      query = Letter.new(content: input)
      query.save
      @sql = last_sql
      hash = {
        result: "success",
        sql: @sql,
        query: "Your letter has been sent! "+
        "There are #{Letter.all.size} letter(s) in the inbox."
      }
      render text: hash.to_json
    rescue => e
      @error = e
      @sql = last_sql
      render partial: "references/query_error"
    end
  end

  #ran by the user
  def knock
    #Invoke the read_letter action which renders the content
    #of all letters to the Gate Guard. This should cause him to
    #call the open_gate action
    load File.join(Rails.root, "lib/gate_guard.rb")

    GateGuard::read_letter request, current_user.tables_prefix

    hash = {
      result: "success",
      description: "The Guard is reading"
    }

    render text: hash.to_json
  end

  #ran by the user
  def push_gate
    #TODO If the gate is unlocked then make it open client side with the link
    #to the next page
    #else respond to the client the door is locked
    gate = Gate.where(tables_prefix: current_user.tables_prefix).first
    if !gate.is_locked
      hash = {
        result: "success",
        description: "The gate is now open!"
      }

      render text: hash.to_json
    else
      hash = {
        result: "failure",
        description: "The gate is still locked!"
      }

      render text: hash.to_json
    end
  end

  #ran by the gate guard
  def read_letters
    #render all the letters with proper tables_prefix as the guard
    #this should cause the guard to hit the open_gate
    @letters = Letter.destroy_all
  end

  #ran by the gate guard
  def unlock_the_gate
    #If it is the proper gate guard with the users prefix in its name
    #then unlock the gate
    user = current_user

    if user.name == "Guard" && user.tables_prefix.present?
      gate = Gate.where(tables_prefix: user.tables_prefix).first
      gate.is_locked = false
      gate.save
      gate.is_locked = false
      hash = {
        result: "success",
        description: "The gate is now unlocked!"
      }
      render text: hash
    else
      hash = {
        result: "failure",
        description: "You are not allowed to unlock the gate"
      }

      render text: hash
    end
  end
end
