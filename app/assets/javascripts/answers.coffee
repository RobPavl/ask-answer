ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-'+ answer_id).show();

  add_answer = (answer) ->

    if gon.current_user
      answer.isSigned = gon.current_user;
      answer.isAnswerAuthor = gon.current_user == answer.user_id;
      answer.isQuestionAuthor = gon.question_author == gon.current_user;


    for attach in answer.attachments
      attach.name = attach.file.url.split('/').slice(-1)[0];

    $('.answers').append -> HandlebarsTemplates['answers/answer'](answer);

    $newComment = $('#new_comment').clone()
    .attr('action',"/answers/#{answer.id}/comments")
    $("#answer-#{answer.id}").append($newComment)

    $editForm = $('#new_answer').clone();
    $editForm.removeClass('new_answer').addClass('edit_answer')
    .removeClass('new_answer_errors')
    .attr('action',"/answers/#{answer.id}")
    .attr('id',"edit-answer-#{answer.id}")
    .attr('value', 'Save')
    $editForm.find('.answer_body textarea').val("#{answer.body}")

    $("#answer-#{answer.id}").append($editForm)

  $("form.new_answer").bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    answer.attachments = data.attachments;
    add_answer(answer) if !$('.answer-'+ answer.id).get
    $('textarea#answer_body').val('')

  questionId = $('.question').data('questionId');

  PrivatePub.subscribe '/questions/' + questionId + '/answers', (data, channel) ->

    answer = $.parseJSON(data['answer']);
    answer.attachments = data.attachments;
    add_answer(answer)

$(document).ready(ready)
$(document).on('page:load',ready)
$(document).on('page:update',ready) 