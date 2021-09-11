$(function() {

  $('.top_slider').slick({
    autoplay: true,
    autoplaySpeed: 2000,
    speed: 1000,
    infinite: true,
    pauseOnHover: false,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
  });

  $('.usage').slick({
    autoplay: true,
    autoplaySpeed: 6000,
    speed: 2000,
    infinite: true,
    pauseOnHover: true,
    slidesToShow: 3,
    slidesToScroll: 1,
    dots: true,
    responsive: [
      {
        breakpoint: 991,
        settings: {
          slidesToShow: 2,
        }
      },
      {
        breakpoint: 767,
        settings: {
          slidesToShow: 1,
        }
      },
    ]
  });

  $('.slick-dots li').on('mouseover', function() {
    $('.sliders').slick('goTo', $(this).index());
  });

});
