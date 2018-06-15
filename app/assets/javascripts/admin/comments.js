$(document).on('load turbolinks:load', function () {
  $('#admin_comments_table').DataTable({
    paging: false,
    searching: false,
    info: false,
  });
});
