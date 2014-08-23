$(document).ready (function() {
  $("body").delegate ("form", "submit", function() {
    if ($("#address_nickname").val() == "" || $("#address_email").val() == "" || $("#address_video").val() == "") {
      event.preventDefault();
    }
  });
});
