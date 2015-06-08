function submit_sqli(action_url)
{
  $.ajax({
    type: "POST",
    url: action_url,
    data: { column: $("#sqli").val(), id: $("#sqli").val() }
  })
  .done(function(msg){
    //console.log(msg);
    data = $.parseJSON(msg);
    $("#display").hide();
    $("#display-sql").text();
    $("#display-query").text();

    if(data.result == "success")
    {
      $("#display").removeClass("alert-danger");
      $("#display").addClass("alert-success");
      $("#display-sql").text(unescapeHtml(data.sql));
      $("#display-query").text(unescapeHtml(data.query));
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

$(document).on("ready page:load", set_listeners);
