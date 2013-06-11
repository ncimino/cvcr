$(document).ready(function () {
  $('.carousel').carousel({
    interval: 5000
  }),
  $('.carousel .carousel-inner .item:first').addClass('active');
  $('.carousel .carousel-indicators li:first').addClass('active');
});