function submit_ma_sqli(target)
{
  //Determine if the request should be sent to the safe or vulnerable action
  if($("#safe_action").hasClass("active"))
  {
    target = "safe_"+target;
  }
  else
  {
    target = "vulnerable_"+target;
  }

  var data = { chest: {} }

  console.log(data)

  if($("#ma_send_size").is(":checked"))data["chest"]["size"]=$("#ma_size").val();
  if($("#ma_send_color").is(":checked"))data["chest"]["color"]=$("#ma_color").val();
  if($("#ma_send_key_slot").is(":checked"))data["chest"]["key_slot"]=$("#ma_key_slot").val();

  $.ajax({
    type:"POST",
    url: target,
    size: $("#ma_size"),
    data: data
  }).always(function(msg){
    console.log(msg);
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
