<template>
  <div id="admin_posts_table">
    <div class="container-fluid opacity-light mh-100">
      <div class="col-sm-10">
      <table class="table border-bottom border-bottom" id="admin_posts_table">
        <thead>
          <tr>
            <th>Id</th>
            <th>Author</th>
            <th>Title</th>
            <th>Edit</th>
            <th>Delete</th>
          </tr>
        </thead>
        <tbody>
          <post-row v-for="(post, index) in myPosts" :post="post" :key="index"></post-row>
        </tbody>
      </table>
      <button class="btn btn-light fixed-action-btn mb-2"
              id="add_post_btn"
              @click.prevent="$store.commit('createAdminPostFormShow')"
              v-if="!$store.state.createAdminPostForm">
        {{ $t('titles.posts.add') }}
      </button>
    </div>
      <post-form v-if="$store.state.createAdminPostForm" :method="'post'"></post-form>
    </div>
  </div>
</template>

<script>
  import PostRow from './PostRow.vue';
  import PostForm from './PostForm.vue';
  import { eventBus } from '../../vue_settings';

  export default {
    props: ['posts'],
    data() {
      return {
        myPosts: this.posts,
      };
    },
    components: {
      PostRow,
      PostForm,
    },
    created() {
      eventBus.$on('postDeleted', (id) => {
        this.myPosts = this.myPosts.filter(post =>  post.id !== id );
      });
      eventBus.$on('postCreated', (post) => {
        this.myPosts.push(post);
      });
    },
  };
</script>
