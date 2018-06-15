$(document).on 'turbolinks:load', ->
  postForm = $('form#new_post')
  addPostBtn = $('#add_post_btn')
  postsList = $('.admin-posts-list tbody')
  adminPostsLink = $('#admin_posts')
  addFileLink = $('#add_file.add_post_attachment')
  editPostForm = $('#edit_post')
  attachmentField = (lastInd) ->
    attachmentField = (lastInd) ->
      lastInd = lastInd || 0
      "<div class=\"custom-file\">" +
      "<input type=\"file\" class=\"custom-file-input\" id=\"post_attachments_attributes_#{lastInd}_file\" name=\"post[attachments_attributes][#{lastInd}][file]\" data-attachment-number=\"#{lastInd}\">" +
      "<label class=\"custom-file-label\" id=\"post_attachments_attributes_#{lastInd}_file\"> #{I18n.t('choose_file')} </label>" +
      "</div>" +
      "<a class=\"remove_file\" data-file_number=\"#{lastInd}\" href=\"#\">#{I18n.t('titles.attachments.delete')}</a>"

  addPostBtn.on 'click', (e) ->
    btn = $(this)
    e.preventDefault()
    btn.hide()
    postForm.show()
    postForm.find('.cancel-btn').one 'click', ->
      postForm.hide()
      btn.show()

  postForm.submit (e) ->
    $('.text-danger').each (i, elem) ->
      $(elem).remove()
    formData = new FormData(this)

    $.ajax
      url: window.location.pathname
      type: 'POST'
      data: formData
      error: (e, xhr, status) ->
      cache: false
      contentType: false
      processData: false
    false

  $('form#edit_post').on 'submit', (e) ->
    formData = new FormData(this)
    $('.text-danger').each (i, elem) ->
      $(elem).remove()

    $.ajax
      url: $(this).attr('action')
      type: 'PATCH'
      data: formData
      error: (e, xhr, status) ->
      cache: false
      contentType: false
      processData: false
    false

  adminPostsLink.on 'click', (e) ->
    e.preventDefault()
    $.get({
      url: adminPostsLink.attr('href')
      success: (data, textStatus) ->
        $('#resources_table').append(JST['admin/foo']({data: data}))
      error: (e, xhr, status, error) ->
    })

  $('.attachments').on 'click', '.remove_file', (e) ->
    e.preventDefault()
    fileNumber = $(e.currentTarget).data('file_number')
    $("#post_form_attachments_attributes_#{fileNumber}_file").val('')

  $('.add_post_attachment').on 'click', (e) ->
    e.preventDefault()
    form = $(e.currentTarget).parent()
    fileInputs = form.find("input[type='file']")
    if fileInputs.length
      lastInd = fileInputs.last().data('attachment-number') + 1
    form.find('.attachments').append(attachmentField(lastInd))
