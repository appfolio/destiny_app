function submit_challenge_setup(user_id_in)
{
  $.ajax({
    type: "POST",
    url: "challenges/setup_challenge_environment"
  })
  .done(function(msg){
    //console.log(msg);
    data = $.parseJSON(msg);
    //$("#display").hide();
    //$("#display-sql").text();
    //$("#display-query").text();

    if(data.result == "success")
    {
      console.log(data);
      //$("#display").removeClass("alert-danger");
      //$("#display").addClass("alert-success");
      //$("#display-sql").text(unescapeHtml(data.sql));
      //$("#display-query").text(unescapeHtml(data.query));
    }
    else
    {
      console.log(data);
      //$("#display").removeClass("alert-success");
      //$("#display").addClass("alert-danger");
      //$("#display-sql").text("An Error has occured: ");
      //$("#display-query").text(unescapeHtml(data.error));
    }

    //$("#display").show("fast");
  });
}

function submit_challenge_restart(user_id_in)
{
  $.ajax({
    type: "POST",
    url: "challenges/restart"
  })
  .done(function(msg){
    //console.log(msg);
    data = $.parseJSON(msg);
    //$("#display").hide();
    //$("#display-sql").text();
    //$("#display-query").text();

    if(data.result == "success")
    {
      console.log(data);
      //$("#display").removeClass("alert-danger");
      //$("#display").addClass("alert-success");
      //$("#display-sql").text(unescapeHtml(data.sql));
      //$("#display-query").text(unescapeHtml(data.query));
    }
    else
    {
      console.log(data);
      //$("#display").removeClass("alert-success");
      //$("#display").addClass("alert-danger");
      //$("#display-sql").text("An Error has occured: ");
      //$("#display-query").text(unescapeHtml(data.error));
    }

    //$("#display").show("fast");
  });
}
