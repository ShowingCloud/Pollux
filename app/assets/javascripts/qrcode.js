$(document).ready (function() {
  $("body").delegate (".websiteaddritem", "mouseover", function() {
    $(this).find("span img").attr("src", "/qrcodes/" + $(this).find("a").text() + ".png");
  });
});
