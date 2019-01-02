<template>
  <div id="foo">
    {{ $t('titles.posts.edit') }}
    <post-form :post="myPost" :method="'patch'"></post-form>
  </div>
</template>

<script>
  import PostForm from './PostForm.vue';
  export default {
    props: ['post'],
    data() {
      return {
        myPost: this.post,
      };
    },
    components: {
      PostForm,
    },
  }
</script>

<style scoped>

</style>
