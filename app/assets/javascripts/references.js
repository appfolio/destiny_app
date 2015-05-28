function submit_sqli(action_url)
{
  $.ajax({
    type: "POST",
    url: action_url,
    data: { column: $("#sqli").val() }
  })
  .done(function(msg){
    console.log(msg);
    $("#display").hide();
    $("#display").text(msg);
    $("#display").show("fast");
  });
}

function set_listeners()
{
  $("#sqli").keypress(function(event) {
    if(event.keyCode == 13)
    {
      var target = $("#sqli").attr('target');
      submit_sqli(target);
    }
  });

  $("#hint-toggle-link").click(function(){
    console.log("tog", "fast")
    $("#hint").toggle();
  });
}

$(document).on("ready page:load", set_listeners);
