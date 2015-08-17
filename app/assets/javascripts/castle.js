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

    console.log(data);
    if(target_url=="push_gate" && data.result=="success")
    {
      setTimeout(function(){
        $("#gate").removeClass("castle-gate-closed");
        $("#gate").addClass("castle-gate-open");
      },550);
    }

    showResponseModal(data);

  });
}

function knock()
{
  ajax_post("knock");
}

function push_gate()
{
  ajax_post("push_gate");
}
