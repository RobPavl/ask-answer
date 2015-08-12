ready = ->
  $(".vote-set").bind 'ajax:success', (e, data, status, xhr) ->
    controller_data = $.parseJSON(xhr.responseText)
    $(".question-vote").html '<a data-type="json" class="vote-cancel" data-remote="true" rel="nofollow" data-method="delete" href="/votes/' + controller_data.id + '/cancel">Cancel vote</a>'

  $(".vote-cancel").bind 'ajax:success', (e, data, status, xhr) ->
    controller_data = $.parseJSON(xhr.responseText)
    $(".question-vote").html '<a data-type="json" class="vote-set" data-remote="true" rel="nofollow" data-method="post" href="/votes/like?question=' + controller_data.id + '">Like</a>'
    $(".question-vote").append '<br>'
    $(".question-vote").append '<a data-type="json" class="vote-set" data-remote="true" rel="nofollow" data-method="post" href="/votes/dislike?question=' + controller_data.id + '">Dislike</a>'

$(document).on('page:update', ready)