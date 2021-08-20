$(function() {

  $('.top_slider').slick({
    autoplay: true,
    autoplaySpeed: 2000,
    speed: 1000,
    infinite: true,
    pauseOnHover: false,
    slidesToShow: 1,
    slidesToScroll: 1,
  });

  $('.sliders').slick({
    autoplay: true,
    autoplaySpeed: 3000,
    speed: 1000,
    dots: true,
    infinite: true,
    pauseOnHover: false,
    slidesToShow: 3,
    slidesToScroll: 1,
  });
  $('.slick-dots li').on('mouseover', function() {
  $('.sliders').slick('goTo', $(this).index());
  });

});
