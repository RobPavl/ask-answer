ready = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    $('form#edit-question-' + question_id).show() 
    
  PrivatePub.subscribe '/questions/index', (data, channel) ->
    question = $.parseJSON(data['question']);
    $('.questions').append -> HandlebarsTemplates['questions/question'](question);

$(document).ready(ready)
$(document).on('page:load',ready)
$(document).on('page:update',ready)