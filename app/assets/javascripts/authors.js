$(function() {
  
  $('.new-author').on('ajax:send', function() {
    $('.loader').css({display: block});
  }).on('ajax:complete', function() {
    $('.loader').css({display: none});
  });

});
