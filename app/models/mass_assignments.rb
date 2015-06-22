#Assumption is that everything in this file is html_safe

#with out strong parameters
wosp_safecode = <<-SAFECODE
  chest = nil
  params.with_shields_down do
    chest = Chest.create(params.permit(:chest=>[:size,:color])[:chest])
  end
SAFECODE
wosp_vulncode = <<-VULNCODE
  chest = nil
  params.with_shields_down do
    chest = Chest.create(params[:chest].to_hash)
  end
VULNCODE
wosp_dispcode = <<-DISPCODE
def without_strong_parameters_action
  #Vulnerability is emulated on the backend as follows...
  #params[:chest].to_hash

  #This is vulnerable in rails apps that don't have
  #strong_parameters or shields up installed and
  #have not setup whitelisting in the model
  Chest.create(params[:chest])

  #controller code for vulnerable and safe versions
  #of mass assignment without strong parameters will
  #look the exact same, because the whitelisting is
  #done in the model.
end

class Chest < ActiveRecord::Base
  ...snip
  #how to whitelist size and color
  attr_accessible :size, :color
  snip...
end

def safe_with_out_strong_parameters
  #MUST have attr_accessible on attributes that are ok
  #to mass assign. This is the old way of protecting
  #from mass assignment, back when it was handled in
  #the model
  chest = Chest.create(params[:chest])
end

def vulnerable_with_out_strong_parameters
  #if the Chest model hasn't white listed attributes
  #with attr_accessible
  chest = Chest.create(params[:chest])
end
DISPCODE

#with strong parameters
wsp_safecode = <<-SAFECODE
  chest = nil
  params.with_shields_down do
    chest_params_check = params.require(:chest).permit(:size,:color)
    chest_default_vals = {"color" => "Brown", "size" => "Large"}
    chest_params = chest_default_vals.merge chest_params_check

    chest = Chest.create(chest_params)
  end
SAFECODE
#TODO get this vulnerable
wsp_vulncode = <<-VULNCODE
  chest = nil
  params.with_shields_down do
    chest_default_vals = {"color"=> "Brown", "size"=>"Large"}
    chest_params = chest_default_vals.merge params[:chest]

    chest = Chest.create(chest_params) #mass assignment!
  end
VULNCODE
wsp_dispcode = <<-DISPCODE
def with_strong_parameters_action
  #This is vulnerable in rails apps that
  #have strong_parameters installed
  Chest.create(params[:chest].to_hash)

  #This is an example of a less obvious
  #vulnerability being introduced in code
  #with strong parameters
  chest_default_vals = {color: "Brown", size:"Large"}
  chest_params = chest_default_vals.merge params[:chest]

  #merge returns a hash to chest_params, and
  #is no longer protecting against mass assignment
  Chest.create(chest_params) #mass assignment!
end

def safe_with_strong_params
  chest_params_check = params.require(:chest).permit(:size,:color)
  chest_default_vals = {"color" => "Brown", "size" => "Large"}
  chest_params = chest_default_vals.merge chest_params_check

  chest = Chest.create(chest_params)
end

def vulnerable_with_strong_params
  chest_default_vals = {"color"=> "Brown", "size"=>"Large"}
  chest_params = chest_default_vals.merge params[:chest]

  chest = Chest.create(chest_params) #mass assignment!
end
DISPCODE

#with shields up parameters
wsu_safecode = <<-SAFECODE
  #this will cause a stringify keys method missing error
  #TODO maybe this should be a named exception instead
  #chest = Chest.create(params[:chest])
  chest = Chest.create(params.permit(:chest=>[:size,:color])[:chest])
SAFECODE
wsu_vulncode = <<-VULNCODE
  chest_default_vals = {"color"=> "Brown", "size"=>"Large"}
  chest_params = params.instance_variable_get(:@params)["chest"]
  chest_attrs = chest_default_vals.merge chest_params

  chest = Chest.create(chest_attrs)
VULNCODE
wsu_dispcode = <<-DISPCODE
def with_shields_up_action
  #you need to include ShieldsUp in the controller you intend
  #to use it in
end

def safe_with_shields_up
  #will not log a warning for the unpermitted parameters
  chest = Chest.create(params.permit(:chest=>[:size,:color])[:chest])
end

def vulnerable_with_shields_up
  chest_default_vals = {"color"=> "Brown", "size"=>"Large"}
  chest_params = params.instance_variable_get(:@params)["chest"]
  chest_attrs = chest_default_vals.merge chest_params

  chest = Chest.create(chest_attrs)
end
DISPCODE

MassAssignments = [
  {
    index: 0,
    name: "wosp", #used for metaprogramming the safe and vuln actions
    title: "Without Strong Parameters or Shields Up",
    info: "<p>Rails 4 by default has the strong parameters gem installed, so this is a"+
    " reference to a very uncommon occurence, most likely seen in legacy apps (and maybe"+
    " some that have even been upgraded)."+
    " <p>Applications using strong parameters can still be vulnerable"+
    " to mass assignment! See the next page for details.</p><p>"+
    " Mass Assignment vulnerabilities without strong parameters enabled are"+
    " very prevelant and high risk. When you can not use strong parameters or shields up"+
    " you must handle whitelisting attributes for mass assignment in the model.</p>"+
    " <p>If you need to whitelist in the model in a Rails 4 app you have to include"+
    " the 'protected_attributes' gem, otherwise you will get an exception raised"+
    " for placing attr_accessible in your models.</p>"+
    " <b>The output you receive from the safe code method is not caused by the"+
    " same type of countermeasures you would actually use in this situation."+
    " This is due to the fact that this is a Rails 4 application and I can not"+
    " emulate the needed environment to use the same countermeasures as you would in"+
    " an application that isn't using strong parameters. (Wouldn't make sense"+
    " to have protected_attributes included in an app that needs to use strong_parameters"+
    " as well)</b>",
    examples: [],
    documentation_link: "#",
    safe_code: wosp_safecode,
    vuln_code: wosp_vulncode,
    displayed_code: wosp_dispcode
  },
  {
    index: 1,
    name: "wsp", #used for metaprogramming the safe and vuln actions
    title: "With Strong Parameters",
    info: "<p>With strong parameters enabled Mass Assignment vulnerabilities require"+
    " a little more mistakes to be made on the side of the developer. There are"+
    " a lot of different ways that strong parameters protection can be lost.</p>"+
    " <p>The most obvious way to lose strong parameters protection is to explicity"+
    " turn the Parameters object stored as 'params' into a hash. At this point you"+
    " lose the needed protection provided by the strong parameters gem.</p>"+
    " <b>If a unpermitted parameter is passed in, strong parameters will output a"+
    " 'Unpermitted parameter: parameter_name' message to the console. The rest of"+
    " the parameters that were permitted will be passed into the calling method.</b>",
    examples: ["Passing in a key_slot value to the safe action will not assign the key_slot",
               "Passing in a key_slot value to the vulnerable action will assign the key_slot"],
    documentation_link: "#",
    safe_code: wsp_safecode,
    vuln_code: wsp_vulncode,
    displayed_code: wsp_dispcode
  },
  {
    index: 2,
    name: "wsu", #used for metaprogramming the safe and vuln actions
    title: "With Shields Up Parameters",
    info: "<p>Using Shields Up parameters is the preferred way to mitigate risk from
    mass assignment vulnerabilities. When using Shields Up you can only use "+
    " permit, require and the [] operator on the Parameters object.</p>This protects"+
    " from developers accidentally passing a hash to an Active Record method call.",
    examples: [],
    documentation_link: "#",
    safe_code: wsu_safecode,
    vuln_code: wsu_vulncode,
    displayed_code: wsu_dispcode
  }
]
