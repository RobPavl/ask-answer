ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-'+ answer_id).show();


  questionId = $('.answers').data('questionId');
  channel = '/questions/' + questionId + '/answers';
  PrivatePub.subscribe channel, (data, channel) ->
    answer = $.parseJSON(data['answer']);

    if gon.current_user
      answer.isSigned = gon.current_user;
      answer.isAnswerAuthor = gon.current_user == answer.user_id;
      answer.isQuestionAuthor = gon.question_author == gon.current_user;

    answer.attachments = data.attachments;

    for attach in answer.attachments
      attach.name = attach.file.url.split('/').slice(-1)[0];

    $('.answers').append -> HandlebarsTemplates['answers/answer'](answer);

$(document).ready(ready)
$(document).on('page:load',ready)
$(document).on('page:update',ready) 