function send_csrf_email()
{
  $.ajax({
    type:"POST",
    url:"csrf/send_csrf_email"
  })
  .done(function(msg){
    $("#csrf-status").removeClass("btn-danger");
    $("#csrf-status").addClass("btn-success");
    check_for_read();
  });
}

function check_for_read()
{
  setTimeout(function(){
    $.ajax({
      type: "GET",
      url:"csrf/check"
    })
    .done(function(msg){
      data = $.parseJSON(msg);
      if(!data.read)
      {
        check_for_read();
      }
      else
      {
        $("#csrf-status").removeClass("btn-success");
        $("#csrf-status").addClass("btn-danger");
      }
    });
  },1000);
}
