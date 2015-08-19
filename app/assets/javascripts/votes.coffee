ready = ->
  $(".vote-set").bind 'ajax:success', (e, data, status, xhr) ->
    arch = $.parseJSON(xhr.responseText)
    $("#" + arch.vote.votable_type.toLowerCase() + "-" + arch.votable.id + '-vote.' + arch.vote.votable_type.toLowerCase() + '-vote').html '<p>Votes:' + arch.votable.rate + '</p>'
    $("#" + arch.vote.votable_type.toLowerCase() + "-" + arch.votable.id + '-vote.' + arch.vote.votable_type.toLowerCase() + '-vote').append '<a data-type="json" class="vote-cancel" data-remote="true" rel="nofollow" data-method="delete" href="/votes/' + arch.vote.id + '">Cancel vote</a>'

  $(".vote-cancel").bind 'ajax:success', (e, data, status, xhr) ->
    arch = $.parseJSON(xhr.responseText)
    $("#" + arch.votable_type.toLowerCase() + "-" + arch.votable.id + '-vote.' + arch.votable_type.toLowerCase() + '-vote').html '<p>Votes:' + arch.votable.rate + '</p>'
    $("#" + arch.votable_type.toLowerCase() + "-" + arch.votable.id + '-vote.' + arch.votable_type.toLowerCase() + '-vote').append '<a data-type="json" class="vote-set" data-remote="true" rel="nofollow" data-method="post" href="/votes/like?votable=' + arch.votable.id + '&votable_type=' + arch.votable_type + '">Like</a>'
    $("#" + arch.votable_type.toLowerCase() + "-" + arch.votable.id + '-vote.' + arch.votable_type.toLowerCase() + '-vote').append '<br>'
    $("#" + arch.votable_type.toLowerCase() + "-" + arch.votable.id + '-vote.' + arch.votable_type.toLowerCase() + '-vote').append '<a data-type="json" class="vote-set" data-remote="true" rel="nofollow" data-method="post" href="/votes/dislike?votable=' + arch.votable.id + '&votable_type=' + arch.votable_type + '">Dislike</a>'

$(document).ready(ready)
$(document).on('page:update', ready)
$(document).on('page:load',ready)