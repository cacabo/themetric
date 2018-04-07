// If a button is disabled, click should do nothing
var $disabled = $('.disabled');
if ($disabled) {
  $('.disabled').click(function(e) {
    e.preventDefalt();
  });
}
