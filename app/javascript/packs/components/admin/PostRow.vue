<template>
  <tr>
    <th>{{ post.id }}</th>
    <th>{{ post.user_id }}</th>
    <th>
      <a :href="`/${$i18n.locale}/admin/posts/${post.id}`">{{ post.title }}</a>
    </th>
    <th>
      <a class="btn btn-link" :href="`/${$i18n.locale}/admin/posts/${post.id}/edit`">
        <span class="fa fa-pencil"></span>
      </a>
    </th>
    <th>
      <a class="btn btn-danger delete-post" @click.prevent="deletePost">
        <span class="fa fa-trash"></span>
      </a>
    </th>
  </tr>
</template>

<script>
  import { eventBus } from '../../vue_settings';

  export default {
    props: ['post'],
    methods: {
      deletePost() {
        this.$http.delete(`/${this.$i18n.locale}/admin/posts/${this.post.id}`).then(response => {
          eventBus.$emit('postDeleted', this.post.id);
        },  response => {
          console.log(response);
        })
      },
    },
  };
</script>

<style scoped>

</style>
