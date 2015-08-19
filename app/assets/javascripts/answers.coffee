ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-'+ answer_id).show();


  questionId = $('.answers').data('questionId');
  channel = '/questions/' + questionId + '/answers';
  PrivatePub.subscribe channel, (data, channel) ->
    console.log(data)
    answer = $.parseJSON(data['answer'])
    $('.answers').append('<h2>' + answer.body + '</h2>')
    $('textarea#answer_body').val('')

$(document).ready(ready)
$(document).on('page:load',ready)
$(document).on('page:update',ready) 