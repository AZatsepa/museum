# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  commentForm = $('#new_comment')
  postId = $('#post-wrapper').data('post_id')
  commentsList = $('.comments')
  addFileLink = $('#add_comment_file')
  commentView = (data) ->
    JST['comment']({data: data})
  createComment = (data) ->
    commentsList.append(commentView(data))

  updateComments = (data) ->
    commentElem = commentsList.find("#comment_#{data.comment.id}").replaceWith(commentView(data))

  destroyComment = (data) ->
    $("#comment_#{data.comment_id}").remove();
  attachmentField = (lastInd) ->
    lastInd = lastInd || 0
    "<div class=\"custom-file\">" +
    "<input type=\"file\" class=\"custom-file-input\" id=\"comment_attachments_attributes_#{lastInd}_file\" name=\"comment[attachments_attributes][#{lastInd}][file]\" data-attachment-number=\"#{lastInd}\">" +
    "<label class=\"custom-file-label\" for=\"comment_attachments_attributes_#{lastInd}_file\"> #{I18n.t('choose_file')} </label>" +
    "</div>" +
    "<a class=\"remove_file\" data-file_number=\"#{lastInd}\" href=\"#\">#{I18n.t('titles.attachments.delete')}</a>"

  $(document).on 'click', '.edit-comment-link', (e) ->
    e.preventDefault();
    $(this).hide();
    commentId = $(this).data('comment_id')
    $('form#edit-comment-' + commentId).show()

  commentForm.submit (e) ->
    $('.text-danger').each (i, elem) ->
      $(elem).remove()
    formData = new FormData(this)

    $.ajax
      url: window.location.pathname + '/comments'
      type: 'POST'
      data: formData
      success: ->
        $('#new_comment_text').val('')
        $('#new_comment .attachments input').val('');
        $('#new_comment .attachments').find('input, a').each (i, elem) ->
          elem.remove() if i isnt 0
      error: (e, xhr, status) ->
        errors = e.responseJSON
        for message in errors
          $('.comment-errors').append("<p class=\"text-danger\">#{message}</p>")
      cache: false
      contentType: false
      processData: false
    false

  $('form#new_post_comment_form').on 'submit', (e) ->
    $('.text-danger').each (i, elem) ->
      $(elem).remove()
    formData = new FormData(this)

    $.ajax
      url: $(this).attr('action')
      type: 'POST'
      data: formData
      success: (data) ->
        $('#new_comment_text').val('')
        $('#new_comment .attachments input').val('');
        $('#new_comment .attachments').find('input, a').each (i, elem) ->
          elem.remove() if i isnt 0
        createComment(data)
      error: (e, xhr, status) ->
        errors = e.responseJSON
        for message in errors
          $('.comment-errors').append("<p class=\"text-danger\">#{message}</p>")
      cache: false
      contentType: false
      processData: false
    false

  $('form#edit_admin_comment').on 'submit', (e) ->
    $('.text-danger').each (i, elem) ->
      $(elem).remove()
    formData = new FormData(this)

    $.ajax
      url: $(this).attr('action')
      type: 'POST'
      data: formData
      error: (e, xhr, status) ->
        errors = e.responseJSON
        for message in errors
          $('.comment-errors').append("<p class=\"text-danger\">#{message}</p>")
      cache: false
      contentType: false
      processData: false
    false

  $('.comments').on 'submit', '.edit_comment', (e) ->
    form = $(this)
    debugger
    formData = new FormData(this)

    $('.text-danger', this).each (i, elem) ->
      $(elem).remove()

    $.ajax
      url: form.attr('action')
      type: 'PATCH'
      data: formData
      success: (data)->
        updateComments(data)
      error: (e, xhr, status) ->
        errors = e.responseJSON
        for message in errors
          form.find('.comment-errors').append("<p class=\"text-danger\">#{message}</p>")
      cache: false
      contentType: false
      processData: false
    false

  $('.attachments').on 'click', '.remove_file', (e) ->
    e.preventDefault()
    fileNumber = $(e.currentTarget).data('file_number')
    $("#comment_attachments_attributes_#{fileNumber}_file").val('')

  $('.add_comment_attachment').on 'click', (e) ->
    e.preventDefault()
    form = $(e.currentTarget).parent()
    fileInputs = form.find("input[type='file']")
    if fileInputs.length
      lastInd = fileInputs.last().data('attachment-number') + 1
    form.find('.attachments').append(attachmentField(lastInd))

  $('.attachments').on 'click', '.remove_file', (e) ->
    e.preventDefault()
    fileNumber = $(e.currentTarget).data('fileNumber')
    $("#comment_attachments_attributes_#{fileNumber}_file").val('')

  App.cable.subscriptions.create { channel: 'CommentsChannel', post_id: postId }, {
    connected: ->
      @perform 'follow'
    ,
    received: (data) ->
      switch data.action
        when 'create' then createComment(data)
        when 'update' then updateComments(data)
        when 'destroy' then destroyComment(data)
  }
