$(function() {
  $('.slider').slick({
    autoplay: true,
    autoplaySpeed: 3000,
    speed: 1000,
    dots: true,
    infinite: true,
    pauseOnHover: false,
    slidesToShow: 1,
    slidesToScroll: 1,
  });
  $('.slick-dots li').on('mouseover', function() {
  $('.slider').slick('goTo', $(this).index());
  });
});
