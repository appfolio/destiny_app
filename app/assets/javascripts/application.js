// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks

function vertically_center()
{
  row = $("#vertically_centered_row");
  row_height = row.height();
  row.css("margin-top",($(window).height()-$(".navbar").height())/2-row_height/2);
}

$(document).ready(function(){
  if($("#vertically_centered_row").length)
  {
    vertically_center();

    $(window).resize(function(){
      vertically_center();
    });
  }
});

function unescapeHtml(safe) {
    return $('<div />').html(safe).text();
}

function showResponseModal(data)
{
  $("#responseModalTitle").text(data.result);
  $("#responseModalBody").text(data.description);
  $("#responseModal").modal('show');
}

function submit_sqli(action_url, target_id)
{
  target_id = typeof target_id !== 'undefined' ? target_id : $("#sqli").val();

  $.ajax({
    type: "POST",
    url: action_url,
    data: { column: $("#sqli").val(), id: target_id }
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
