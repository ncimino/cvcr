$(document).ready(function () {
  $('.carousel').carousel({
    interval: 5000
  }),
  $('.carousel .carousel-inner .item:first').addClass('active');
  $('.carousel .carousel-indicators li:first').addClass('active');
  $('.clickable').click(function() {
    window.location = $(this).find('a').attr('href');
  });
  $('*[data-confirm]').click(function(){
    return confirm($(this).attr('data-confirm'));
  });
  $('.buy-button').click(function() {
    alert('On-line purchases are currently disabled.');
  });
});