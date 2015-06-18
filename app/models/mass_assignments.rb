#Assumption is that everything in this file is html_safe

#TODO with out strong parameters
wosp_safecode = <<-SAFECODE
  chest = Chest.create(params[:chest])
SAFECODE
wosp_vulncode = <<-VULNCODE
  chest = Chest.create(params[:chest].to_hash)
VULNCODE
wosp_dispcode = <<-DISPCODE
def without_strong_parameters_action
  #Vulnerability is emulated on the backend as follows...
  #params[:chest].to_hash

  #This is vulnerable in rails apps that
  #don't have strong_parameters installed
  Chest.create(params[:chest])
end
DISPCODE

#TODO with strong parameters
wsp_safecode = <<-SAFECODE
  chest_params_check = params.require(:chest).permit(:size,:color)
  chest_default_vals = {"color" => "Brown", "size" => "Large"}
  chest_params = chest_default_vals.merge chest_params_check
  puts chest_params.class

  chest = Chest.create(chest_params)
SAFECODE
wsp_vulncode = <<-VULNCODE
  chest_default_vals = {color: "Brown", size:"Large"}
  chest_params = chest_default_vals.merge params[:chest]

  chest = Chest.create(chest_params) #mass assignment!
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
DISPCODE

#TODO with shields up parameters
wsu_safecode = <<-SAFECODE
  Chest.create(params)
SAFECODE
wsu_vulncode = <<-VULNCODE

VULNCODE
wsu_dispcode = <<-DISPCODE

DISPCODE

MassAssignments = [
  {
    index: 0,
    name: "wosp", #used for metaprogramming the safe and vuln actions
    title: "Without Strong Parameters",
    info: "<p>Rails 4 by default has the strong parameters gem installed, so this is a"+
    " reference to a very uncommon occurence, most likely seen in legacy apps (and maybe"+
    " some that have even been upgraded)."+
    " <p>Applications using strong parameters can still be vulnerable"+
    " to mass assignment! See the next page for details.</p><p>"+
    " Mass Assignment vulnerabilities without strong parameters enabled are"+
    " very prevelant and high risk. Refer to the documentation on how to"+
    " write secure code when you can not use strong parameters or shields up.</p>"+
    " <b>The errors you receive from the safe code method are not caused by the"+
    " same type of countermeasures you would actually use in this situation."+
    " This is due to the fact that this is a Rails 4 application and I can not"+
    " emulate the needed environment to use the same countermeasures as you would in"+
    " an application that isn't using strong parameters.</b>",
    examples: ["here is an example for BLALDSKJADKJSD","nother one"],
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
    " 'Unpermitted parameter: parameter_name' message to the console.</b>",
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
    info: "without strong parameters you do BLAARRRRGGHGGHGHGGHGHHG",
    examples: ["here is an example for BLALDSKJADKJSD","nother one"],
    documentation_link: "#",
    safe_code: wsu_safecode,
    vuln_code: wsu_vulncode,
    displayed_code: wsu_dispcode
  }
]
