window.onscroll = function() {
  if (document.body.scrollTop <= 20) {
    $('.navbar').addClass('top');
  } else {
    $('.navbar').removeClass('top');
  }
}
