$(document).ready(function() {

  /* Random color generator */
  function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }

  /* Flashing buttons */
  if($('.btn-flash').length) {
    var signInButton = $('.btn-flash');
    setInterval(function() {
      var hex = getRandomColor();
      signInButton.css({ 'background': hex });
    }, 600);
  }

  /* Flashing wordmarks */
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
    
  }

  /* Intermediate processing loader */
  if($('.loading').length) {
    var $loading = $('.loading');
    var $steps = $loading.find('.step');
    var $progress = $loading.find('.progress');
    var stepIndex = 0;
    function updateProgress(status) {
      $steps.eq(stepIndex).addClass('complete');
      stepIndex = status;
      $steps.removeClass('current');
      if(stepIndex == 0) {
        $steps.eq(stepIndex).addClass('current');
      } else if (stepIndex == 1) {
        $steps.eq(stepIndex).addClass('current');
        $progress.height('50%');
      } else if (stepIndex == 2) {
        $steps.eq(stepIndex).addClass('complete');
        $progress.height('100%');
        $('.loading-btn').hide();
        $('.ready-btn').show();
      }
    }

    setInterval(function() {
      $.when($.getJSON("tweets/" + currentUser.id)).done( function(json) {
        var status = json['status'];
        if(status !== stepIndex) {
          updateProgress(status);
        }
      });
    }, 300);
  }

});