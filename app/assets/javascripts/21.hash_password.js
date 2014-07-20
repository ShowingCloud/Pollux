function hash_password() {
  if ($('#user_password').length) {
    $('#user_password').val ($.sha256 ($.sha256 ($('#user_username').val() + $('#user_password').val())));
  } else {
    $('#password').val ($.sha256 ($.sha256 ($('#username').val() + $('#password').val())));
  }
}
