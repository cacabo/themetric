var last = 0;
addNavListener();

$(document).ready(function() {
  last = 0;
  addNavListener();
});

function addNavListener() {
  window.addEventListener('scroll', function() {
    var $navbarWrapper = $('#navbar-wrapper');

    var current = document.documentElement.scrollTop;
    if (!current) current = window.pageYOffset;

    if (current <= 150) {
      $navbarWrapper.addClass('top');
    } else {
      $navbarWrapper.removeClass('top');
    }

    // If the user scrolled a significant amount
    if (Math.abs(current - last) >= 50) {
      // If the user is scrolling down the page,
      // hide the navbar
      if (current >= 400 && current > last) {
        $navbarWrapper.addClass('up');
      } else {
        $navbarWrapper.removeClass('up');
      }
      last = current;
    }
  });
}
