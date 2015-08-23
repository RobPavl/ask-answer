ready = ->

  add_comment = (comment) ->
    $('div#' + comment.commentable_type.toLowerCase() + '-' + comment.commentable_id).find('.comments ul').append ->
      HandlebarsTemplates['comments/comment'](comment) if !$('div#comment-'+comment.id).length

  $("form.new_comment").bind 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText)
    add_comment(comment)
    $('textarea#comment_body').val('')

  questionId = $('.question').data('questionId');

  PrivatePub.subscribe '/question/' + questionId + '/comments', (data, channel) ->
    comment = $.parseJSON(data['comment']);
    add_comment(comment)

$(document).ready()
$(document).on('page:load', ready)
$(document).on('page:update', ready)
