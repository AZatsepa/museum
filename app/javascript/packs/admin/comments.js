$(document).on('load turbolinks:load', () => {
  $('#admin_comments_table').DataTable({
    paging: false,
    searching: false,
    info: false,
  });
});
