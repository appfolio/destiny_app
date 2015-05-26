function submit_sqli()
{
  console.log("sending");
  $.ajax({
    type: "POST",
    url: "exec_sqli",
    data: { column: $("#sqli").val() }
  })
  .done(function(msg){
    console.log(msg);
  });
}
