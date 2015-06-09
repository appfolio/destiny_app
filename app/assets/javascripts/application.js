// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks

function unescapeHtml(safe) {
    return $('<div />').html(safe).text();
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
