$(document).ready(function() {

  /* Random color generator */
  function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    console.log(color);
    return color;
  }

  /* Flashing home page frames */
  if($('.feed').length) {
    var items = $('.feed .item');
    var randIndex;
    var prevRandIndex;
    setInterval(function() {
      function setRandIndex() {
        randIndex = Math.floor(Math.random() * items.length);
        if(randIndex === prevRandIndex) {
          setRandIndex();
        }
        prevRandIndex = randIndex;
      }
      setRandIndex();
      var item = items[randIndex];
      var hex = getRandomColor();
      $(item).css({'border-color': hex});
    }, 300);
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
    }, 300);
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
    }, 600);
  }

  /* Admin Bar */
  if($('.admin-bar').length) {
    // Theme switcher
    $('#theme-select').change(function() {
      var val = $(this).val();
      var slug = $(this).find('option:selected').data('slug');
      $('article').attr('class', 'theme ' + slug);
    });

    $('#edit').click(function(e) {
      e.preventDefault();
      if($('.editable').is(':visible')) {
        $(this).text('Edit');
        $('#cancel').hide();
        $('.editable').hide();
        var formData = $('#update-form').serialize();
        console.log(formData);
      } else {
        $(this).text('Save');
        $('#cancel').show();
        $('.editable').show();
      }
    });

  }

});