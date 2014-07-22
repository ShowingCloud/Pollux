function hash_password() {
  if ($('#user_password').length) {
    if ($('#user_password').val() != "") {
      $('#user_password').val ($.sha256 (
            $('#user_username').val() + $('#user_password').val()));
    }
  } else {
    $('#password').val ($.sha256 (
          $.sha256 ($('#username').val() + $('#password').val())
        + $('#captcha').val()));
  }
}
