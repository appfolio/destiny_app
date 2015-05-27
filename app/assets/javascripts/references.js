function submit_sqli()
{
  $.ajax({
    type: "POST",
    url: "exec_sqli",
    data: { column: $("#sqli").val() }
  })
  .done(function(msg){
    console.log(msg);
    $("#display").hide();
    $("#display").text(msg);
    $("#display").show("fast");
  });
}

$(document).ready(function(){
  $("#sqli").keypress(function(event) {
    console.log(event.keyCode);
    if(event.keyCode == 13)
    {
      submit_sqli();
    }
  });
});
