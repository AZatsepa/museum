$(document).on('turbolinks:load', () => {
  const postForm = $('form#new_post');
  const addPostBtn = $('#add_post_btn');
  const adminPostsLink = $('#admin_posts');
  function attachmentField(lastIndex) {
    return `<div class="custom-file">
              <input type="file" class="custom-file-input" id="post_attachments_attributes_${lastIndex}_file" name="post[attachments_attributes][${lastIndex}][file]" data-attachment-number="${lastIndex}">
              <label class="custom-file-label" id="post_attachments_attributes_${lastIndex}_file"> #{I18n.t('choose_file')} </label>
            </div>
            <a class="remove_file" data-file_number="${lastIndex}" href="#">${I18n.t('titles.attachments.delete')}</a>`; // eslint-disable-line no-undef
  }

  $('form#edit_post').on('submit', function () {
    const url = $(this).attr('action');
    $('.text-danger').each((i, elem) => {
      $(elem).remove();
    });

    $.ajax({
      url,
      type: 'PATCH',
      data: new FormData(this), // eslint-disable-line no-undef
      cache: false,
      contentType: false,
      processData: false,
    });
    return false;
  });

  adminPostsLink.on('click', (e) => {
    e.preventDefault();
    $.get({
      url: adminPostsLink.attr('href'),
      success(data) {
        $('#resources_table').append(jst.renderFile('admin/foo', { data }, function(err, ctx) {
          // second arg are optional,
          // the callback can be the second arg
        }));
      },
    });
  });

  // $('.attachments').on('click', '.remove_file', (e) => {
  //   e.preventDefault();
  //   const fileNumber = $(e.currentTarget).data('file_number');
  //   $(`#post_form_attachments_attributes_${fileNumber}_file`).val('');
  // });
  //
  // $('.add_post_attachment').on('click', (e) => {
  //   e.preventDefault();
  //   const form = $(e.currentTarget).parent();
  //   const fileInputs = form.find("input[type='file']");
  //   let lastInd;
  //   if (fileInputs.length) {
  //     lastInd = fileInputs.last().data('attachment-number') + 1;
  //   } else {
  //     lastInd = 0;
  //   }
  //   form.find('.attachments').append(attachmentField(lastInd));
  // });
});
