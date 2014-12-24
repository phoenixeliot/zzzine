$(document).ready(function() {

  if($('.theme-picker').length) {
    $('.theme-option').click(function(e){
      e.preventDefault();
      var slug = $(this).data('style-slug');
      $('body').attr('class', 'theme ' + slug);
    });
  }

});