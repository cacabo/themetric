var $disabled = $('.disabled');
if ($disabled) {
  $('.disabled').click(function(e) {
    e.preventDefalt();
  });
}
