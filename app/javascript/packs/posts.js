(($) => {
  $(document).on('turbolinks:load', () => {
    const postsList = $('.posts-list');

    App.cable.subscriptions.create('PostsChannel', {
      connected() {
        this.perform('follow');
      },
      received(data) {
        postsList.append(data);
      },
    });
  });
})(jQuery);
