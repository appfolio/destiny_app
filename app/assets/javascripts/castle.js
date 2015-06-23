$(document).on("ready page:load", set_listeners);

function set_listeners()
{
  $("#sqli").keypress(function(event) {
    if(event.keyCode == 13)
    {
      var target = $("#sqli").attr('target');
      submit_sqli(target);
    }
  });
}

function ajax_post(target_url)
{
  $.ajax({
    type: "POST",
    url: target_url
  })
  .always(function(msg){

    data = $.parseJSON(msg);

    showResponseModal(data);

  });
}

function knock()
{
  ajax_post("knock");
}

function push_gate()
{
  $("#responseModal").focusout(function(event){
    //TODO run javascript to open the gate visually
    //and generate a link to the next challenge
  });
  ajax_post("push_gate");
}
