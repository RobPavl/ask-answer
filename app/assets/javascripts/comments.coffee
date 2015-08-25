ready = ->

  add_comment = (comment) ->
    $('div#' + comment.commentable_type.toLowerCase() + '-' + comment.commentable_id).find('.comments ul').append ->
      HandlebarsTemplates['comments/comment'](comment) if !$('div#comment-'+comment.id).length

  $("form.new_comment").on 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText)
    add_comment(comment)
    $('textarea#comment_body').val('')
  .on 'ajax:error', (e, xhr, status, error) ->
    response = $.parseJSON(xhr.responseText)
    comment = response.comment
    errors = response.errors
    $('div#' + comment.commentable_type.toLowerCase() + '-' + comment.commentable_id).find('div.new_comment_errors').html('<p>' + errors + '</p>')

  questionId = $('.question').data('questionId');

  PrivatePub.subscribe '/question/' + questionId + '/comments', (data, channel) ->
    comment = $.parseJSON(data['comment']);
    add_comment(comment)

$(document).ready()
$(document).on('page:load', ready)
$(document).on('page:update', ready)
