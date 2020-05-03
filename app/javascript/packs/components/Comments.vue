<template>
  <div>
    <div class="comments">
      <app-comment v-for="(comment, index) in mutableComments" :comment="comment" :key="index"></app-comment>
    </div>
    <app-comment-form :post_id="myPostId" v-if="this.$can('create', 'Comment')"></app-comment-form>
  </div>
</template>

<script>
  import Comment from './Comment.vue'
  import NewCommentForm from './NewCommentForm.vue'

  export default {
    name: 'Comments',
    props: ['comments', 'post_id'],
    components: {
      appComment: Comment,
      appCommentForm: NewCommentForm,
    },
    data() {
      return {
        myPostId: this.post_id,
      };
    },
    computed: {
      mutableComments() {
        return this.comments;
      },
    },
    created() {
      const this2 = this;

      App.cable.subscriptions.create( // eslint-disable-line no-undef
        { channel: 'CommentsChannel', post_id: this2.post_id },
        { connected() {
            return this.perform('follow');
          },
          received(data) {
            switch (data.action) {
              case 'create': {
                this2.comments.push(data.comment);
                break;
              }
              case 'update': {
                const index = this2.comments.findIndex(comment => comment.id === data.comment.id);
                const updatedComment = this2.comments[index];
                Object.keys(updatedComment).forEach(key => updatedComment[key] = null);
                Object.entries(data.comment).forEach(entry => this2.$set(updatedComment, entry[0], entry[1]));
                break;
              }
              case 'destroy': {
                const index = this2.comments.findIndex(comment => comment.id === data.comment.id);
                this2.comments.splice(index, 1);
                break;
              }
              default: {
                break;
              }
            }
          },
        },
      );
    },
  };
</script>

<style scoped>

</style>
