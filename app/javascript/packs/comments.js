// $(document).on('turbolinks:load', () => {
//   const commentForm = $('#new_comment');
//   const postId = $('#post-wrapper').data('post_id');
//   const commentsList = $('.comments');
//   const commentView = (data) => {
//     jst.renderFile('comment', { data }, function (err, ctx) {
//       // second arg are optional,
//       // the callback can be the second arg
//     });
//   };
//   const createComment = (data) => {
//     commentsList.append(commentView(data));
//   };
//
//   const updateComments = (data) => {
//     commentsList
//       .find(`#comment_${data.comment.id}`)
//       .replaceWith(commentView(data));
//   };
//
//   const destroyComment = (data) => {
//     $(`#comment_${data.comment_id}`).remove();
//   };
//   const attachmentField = (lastInd) => {
//     const lastIndex = lastInd || 0;
//     return `<div class="custom-file">
//               <input type="file" class="custom-file-input" id="comment_attachments_attributes_${lastIndex}_file" name="comment[attachments_attributes][${lastIndex}][file]" data-attachment-number="${lastIndex}">
//               <label class="custom-file-label" for="comment_attachments_attributes_${lastIndex}_file"> ${I18n.t('choose_file')} </label>
//             </div>
//             <a class="remove_file" data-file_number="${lastIndex}" href="#">${I18n.t('titles.attachments.delete')}</a>`;// eslint-disable-line no-undef
//   };
//
//   $(document).on('click', '.edit-comment-link', function (e) {
//     e.preventDefault();
//     $(this).hide();
//     const commentId = $(this).data('comment_id');
//     $(`form#edit-comment-${commentId}`).show();
//   });
//
//   commentForm.submit(function () {
//     $('.text-danger').each((i, elem) => {
//       $(elem).remove();
//     });
//     const formData = new FormData(this);// eslint-disable-line no-undef
//
//     $.ajax({
//       url: `${window.location.pathname}/comments`,
//       type: 'POST',
//       data: formData,
//       success() {
//         $('#new_comment_text').val('');
//         $('#new_comment .attachments input').val('');
//         $('#new_comment .attachments').find('input, a').each((i, elem) => {
//           if (i !== 0) {
//             elem.remove();
//           }
//         });
//       },
//       error(err) {
//         const errors = err.responseJSON;
//         for (const message in errors) {
//           $('.comment-errors').append(`<p class="text-danger">${message}</p>`)
//         }
//       },
//       cache: false,
//       contentType: false,
//       processData: false,
//     });
//     return false;
//   });
//
//   $('form#new_post_comment_form').on('submit', function () {
//     $('.text-danger').each((i, elem) => { $(elem).remove(); });
//     const formData = new FormData(this);// eslint-disable-line no-undef
//
//     $.ajax({
//       url: $(this).attr('action'),
//       type: 'POST',
//       data: formData,
//       success(data) {
//         $('#new_comment_text').val('');
//         $('#new_comment .attachments input').val('');
//         $('#new_comment .attachments').find('input, a').each((i, elem) => {
//           if (i !== 0) {
//             elem.remove();
//           }
//         });
//         createComment(data);
//       },
//       error(e) {
//         const errors = e.responseJSON;
//         for (const message in errors) {
//           $('.comment-errors').append(`<p class="text-danger">${message}</p>`)
//         }
//       },
//       cache: false,
//       contentType: false,
//       processData: false,
//     });
//     return false;
//   });
//
//   $('form#edit_admin_comment').on('submit', function () {
//     $('.text-danger').each((i, elem) => {
//       $(elem).remove();
//     });
//     const formData = new FormData(this);// eslint-disable-line no-undef
//
//     $.ajax({
//       url: $(this).attr('action'),
//       type: 'POST',
//       data: formData,
//       error(e) {
//         const errors = e.responseJSON;
//         for (const message in errors) {
//           $('.comment-errors').append(`<p class="text-danger">${message}</p>`);
//         }
//       },
//       cache: false,
//       contentType: false,
//       processData: false,
//     });
//     return false;
//   });
//
//   commentsList.on('submit', '.edit_comment', function () {
//     const form = $(this);
//     const formData = new FormData(this);// eslint-disable-line no-undef
//
//     $('.text-danger', this).each((i, elem) => {
//       $(elem).remove();
//     });
//
//     $.ajax({
//       url: form.attr('action'),
//       type: 'PATCH',
//       data: formData,
//       success(data) {
//         updateComments(data);
//       },
//       error(err) {
//         const errors = err.responseJSON;
//         for (const message in errors) {
//           form.find('.comment-errors').append(`<p class="text-danger">${message}</p>`);
//         }
//       },
//       cache: false,
//       contentType: false,
//       processData: false,
//     });
//     return false;
//   });
//
//   $('.attachments').on('click', '.remove_file', (e) => {
//     e.preventDefault();
//     const fileNumber = $(e.currentTarget).data('file_number');
//     $(`#comment_attachments_attributes_${fileNumber}_file`).val('');
//   });
//
//   $('.add_comment_attachment').on('click', (e) => {
//     e.preventDefault()
//     const form = $(e.currentTarget)
//       .parent();
//     const fileInputs = form.find("input[type='file']");
//     if (fileInputs.length) {
//       const lastInd = fileInputs.last()
//         .data('attachment-number') + 1;
//       form.find('.attachments')
//         .append(attachmentField(lastInd));
//     }
//   });
//
//
//   App.cable.subscriptions.create( // eslint-disable-line no-undef
//     { channel: 'CommentsChannel', post_id: postId },
//     {
//       connected() {
//         return this.perform('follow');
//       },
//       received(data) {
//         switch (data.action) {
//           case 'create': {
//             createComment(data);
//             break;
//           }
//           case 'update': {
//             updateComments(data);
//             break;
//           }
//           case 'destroy': {
//             destroyComment(data);
//             break;
//           }
//           default: {
//             break;
//           }
//         }
//       },
//     },
//   );
// });
