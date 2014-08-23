$(document).ready (function() {
  $("body").delegate ("form", "submit", function() {
    if ($("#address_nickname").val() == "" || $("#address_email").val() == "" || $("#address_video").val() == "") {
      alert("请填写完整信息");
      event.preventDefault();
    }
  });
});
