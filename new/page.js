$(document).ready(function() {
        $('#Home').popover({content: 'Home', animation: true, trigger: 'hover', placement: 'bottom'});
        $('#Code').popover({content: 'Projects', animation: true, trigger: 'hover', placement: 'bottom'});
        $('#Contact').popover({content: 'Contact', animation: true, trigger: 'hover', placement: 'bottom'});
        $('#Blog').popover({content: 'Blog', animation: true, trigger: 'hover', placement: 'bottom'});
        $('#Head').scrollTop(80);
        $('#Head2').scrollTop(80);
        $('#Head3').scrollTop(80);
$(function() {
  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 300);
        return false;
      }
    }
  });
});
});
