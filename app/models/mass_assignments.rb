#Assumption is that everything in this file is html_safe

#TODO with out strong parameters
wosp_safecode = <<-SAFECODE
  Chest.create(params)
SAFECODE
wosp_vulncode = <<-VULNCODE
  Chest.create(params)
VULNCODE
wosp_dispcode = <<-DISPCODE
def without_strong_parameters_action
  Chest.create(params)
end
DISPCODE

#TODO with strong parameters
wsp_safecode = <<-SAFECODE

SAFECODE
wsp_vulncode = <<-VULNCODE

VULNCODE
wsp_dispcode = <<-DISPCODE

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
    info: "The Mass Assignment vulnerability without strong parameters present"+
    " is very easily exploitable.",
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
    info: "With strong parameters exploiting Mass Assignment is a little more"+
    " difficult, but it has been found to be a prevalent vulnerability in large apps.",
    examples: ["here is an example for BLALDSKJADKJSD","nother one"],
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
