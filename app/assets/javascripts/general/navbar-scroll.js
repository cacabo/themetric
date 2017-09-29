var last = 0;
addNavListener();

$(document).ready(function() {
  last = 0;
  addNavListener();
});

function addNavListener() {
  window.addEventListener('scroll', function() {
    var current = document.documentElement.scrollTop;

    if (current <= 20) {
      $('.navbar').addClass('top');
    } else {
      $('.navbar').removeClass('top');
    }

    if (Math.abs(current - last) >= 40) {
      if (current >= 400 && current > last) {
        $('.fixed.front').slideUp(200);
      } else {
        $('.fixed.front').slideDown(200);
      }
      last = current;
    }
  });
}
