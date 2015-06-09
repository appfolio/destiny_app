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

  $("#hint-toggle-link").click(function(){
    $("#hint").toggle();
  });
}

function set_popover_template()
{
  var template = [
    '<div class="popover" style="width:300px;" role="tooltip">',
      '<div class="popover-content">',
      '</div>',
    '</div>'
  ].join('');

  return template;
}

$(function () {
  for(i=1;i<=3;i++)
  {
    $("#chest"+i).popover({
      placement:"top",
      html:true,
      content: $("#chest"+i+"-content").html(),
      template: set_popover_template()
    });
  }
})

function submit_challenge(target_url)
{
  $.ajax({
    type: "POST",
    url: target_url
  })
  .always(function(msg){

    data = $.parseJSON(msg);
    console.log(data);

    showResponseModal(data);

  });
}

function submit_challenge_setup()
{
  $("#responseModal").focusout(function(event){
    go_to_challenge();
  });

  submit_challenge("challenges/setup_challenge_environment");
}

function submit_challenge_restart()
{
  $("#responseModal").focusout(function(event){
    location.reload();
  });

  $("#responseModalContinue").attr("onclick","location.reload()")

  submit_challenge("challenges/restart");
}

function go_to_challenge()
{
  window.location.href="challenges/start"
}

function showResponseModal(data)
{
  $("#responseModalTitle").text(data.result);
  $("#responseModalBody").text(data.description);
  $("#responseModal").modal('show');
}

$(window).on('shown.bs.modal',function(){
  $('#responseModalContinue').focus()
});

function submit_key(action_url, target_id)
{
  $.ajax({
    type: "POST",
    url: action_url,
    data: { column: $("#chest"+target_id+"-value").val(), id: target_id }
  })
  .done(function(msg){
    data = $.parseJSON(msg);
    $("#display").hide();
    $("#display-sql").text();
    $("#display-query").text();

    console.log(data)

    if(data.result == "success")
    {
      $("#display").removeClass("alert-danger");
      $("#display").addClass("alert-success");
      $("#display-sql").text(unescapeHtml(data.sql));
      $("#display-query").text(unescapeHtml(data.query));

      $("#chest"+target_id).removeClass("treasure-chest-closed");
      $("#chest"+target_id).addClass("treasure-chest-opened");
    }
    else
    {
      $("#display").removeClass("alert-success");
      $("#display").addClass("alert-danger");
      $("#display-sql").text("An Error has occured: ");
      $("#display-query").text(unescapeHtml(data.error));
    }

    $("#display").show("fast");
  });
}



















