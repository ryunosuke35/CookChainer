$(function() {
  $('#accordion dd').hide();
  $('#accordion dt').on('click', function() {
    $(this).next('dd').slideToggle('fast');
  });
  $('#accordion dd').hide();
});