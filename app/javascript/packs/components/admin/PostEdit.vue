<template>
  <div id="foo">
    {{ $t('titles.posts.edit') }}
    <edit-post-form :post="myPost"></edit-post-form>
  </div>
</template>

<script>
  import EditPostForm from './EditPostForm.vue';
  export default {
    props: ['post'],
    data() {
      return {
        myPost: this.post,
      };
    },
    components: {
      EditPostForm,
    },
  }
</script>

<style scoped>

</style>
