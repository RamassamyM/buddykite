$(".wrapper").click(function () {
  $wrapper = $(this);
  $content = $wrapper.next();
  $content.slideToggle(500, function () {
    if ($content.is(":visible")) {
      $wrapper.children('i').removeClass("fa-angle-down").addClass("fa-angle-up")
    } else {
      $wrapper.children('i').removeClass("fa-angle-up").addClass("fa-angle-down")
    }
    $wrapper.children('p').text(function () {
        return $content.is(":visible") ? "Hide review" : "Show review";
    });
  });
});
