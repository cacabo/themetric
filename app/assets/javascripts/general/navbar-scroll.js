let last = 0;

$(document).ready(function() {
  last = 0;
});

window.onscroll = function() {
  const current = document.body.scrollTop;
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
}
