$(document).ready(function() {

  if($('.theme-picker').length) {
    $('.theme-option').click(function(e){
      e.preventDefault();
      var slug = $(this).data('style-slug');
      $('body').attr('class', 'theme ' + slug);
    });
  }

  function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }

  if($('.wordmark').length) {

    var letters = $('.wordmark .letter');
    var randLetterIndex;
    var prevRandLetterIndex;

    setInterval(function() {
      function setRandLetterIndex() {
        randLetterIndex = Math.floor(Math.random() * letters.length);
        if(randLetterIndex === prevRandLetterIndex) {
          setRandLetterIndex();
        }
        prevRandLetterIndex = randLetterIndex;
      }
      setRandLetterIndex();
      var letter = letters[randLetterIndex];
      var hex = getRandomColor();
      $(letter).attr({ 'fill': hex });
    }, 100);


    var signInButton = $('.btn-large');
    setInterval(function() {
      var hex = getRandomColor();
      signInButton.css({ 'background': hex });
    }, 600);

    var themes = $('.wordmark .letter');
    var randLetterIndex;
    var prevRandLetterIndex;

    setInterval(function() {
      function setRandLetterIndex() {
        randLetterIndex = Math.floor(Math.random() * letters.length);
        if(randLetterIndex === prevRandLetterIndex) {
          setRandLetterIndex();
        }
        prevRandLetterIndex = randLetterIndex;
      }
      setRandLetterIndex();
      var letter = letters[randLetterIndex];
      var hex = getRandomColor();
      $(letter).attr({ 'fill': hex });
    }, 100);

    /*
    letters.hover(function() {
      $(this).remove();
    });
    */
    
  }


});