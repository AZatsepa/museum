<template>
    <div class="border-bottom comment">
    <% include ActionView::Helpers %>
        <template v-if="!editMode">
          {{ myComment.text }}
          <div v-for="(image, index) in myComment.images" :image="image" :key="index">
           <div class="row">
             <a :href="image.url" class="col p-2">
               <img :src="image.url" width="125">
             </a>
           </div>
          </div>
          <div class="row">
           <a class="btn btn-link fa fa-pencil edit-comment-link"
              @click.prevent="editMode = true"
              v-if="this.$can('update', 'Comment', myComment)">
           </a>
           <a @click.prevent="destroyComment"
              class="btn btn-link fa fa-trash delete-comment-link"
              v-if="this.$can('destroy', 'Comment', myComment)">
           </a>
          </div>
        </template>
        <div class="row" v-else>
         <div class="col">
           <form>
             <div class="form-group">
               <textarea class="form-control" rows="15" v-model="myComment.text" id="comment_text">
               </textarea>
             </div>
             <div class="form-group">
               <div v-for="(image, index) in myComment.images" :image="image" :key="index">
                 <div class="row">
                   {{ imageName(image) }}
                   <input type="checkbox" @click="destroyImage(image)"> destroy
                 </div>
                </div>
             </div>
             <div>
               <div class="custom-file" v-if="showImageInput">
                 <input type="file"
                        class="custom-file-input"
                        @change="onImageSelected($event)">
                 <label class="custom-file-label">
                   'Choose your image'
                 </label>
               </div>
             </div>
             <a class="add_comment_attachment" @click.prevent="showImageInput = !showImageInput">
               {{ $t('titles.attachments.add') }}
             </a>
             <div class="form-group">
               <button class="btn btn-success" @click.prevent="updateComment">
                 {{ $t('titles.comments.edit') }}
               </button>
               <button class="btn btn-success" @click.prevent="editMode = false">
                 {{ $t('cancel') }}
               </button>
             </div>
           </form>
         </div>
       </div>
        <div class="row">
          <div class="col-3 p-3">
             {{ $t('titles.author') }}: {{ myComment.user.name }}
          </div>
          <div class="col-9 p-3">
             {{ `${$t('created_at')}: ${new Date(myComment.created_at).toDateString()}` }}
          </div>
       </div>
     </div>
</template>

<script>
  import objectToFormData from '../shared/object_to_form_data';

  export default {
    name: 'Comment',
    props: ['comment', 'namespace'],
    data() {
      return {
        myComment: this.comment,
        editMode: false,
        showImageInput: false,
        myNamespace: this.namespace ? `/${this.namespace}` : '',
      };
    },
    methods: {
      destroyComment() {
        this.$http.delete(`/posts/${this.comment.post_id}/comments/${this.comment.id}`).then(response => {
        },  response => {
          console.log(response);
        });
      },
      updateComment() {
        const commentToUpdate = objectToFormData(this.myComment, null, 'comment');
        this.$http
            .patch(`${this.myNamespace}/posts/${this.comment.post_id}/comments/${this.comment.id}`, commentToUpdate)
            .then(response => {
                this.editMode = false;
                this.myComment = response.data.comment;
              },  response => {
                console.log(response);
            });
      },
      destroyImage(image) {
        this.myComment.destroy_images = this.myComment.destroy_images || [];
        if (this.myComment.destroy_images.includes(image.id)) {
          this.myComment.destroy_images = this.myComment.destroy_images.filter(elem => elem !== image.id)
        } else {
          this.myComment.destroy_images.push(image.id);
        }
      },
      onImageSelected(event) {
        this.comment.images.push(event.target.files[0]);
        this.showImageInput = false;
      },
      imageName(image) {
        if (image instanceof File) {
          return image.name;
        } else {
          return image.filename;
        }
      },
      log(image) {
        debugger;
      },
    },
  };
</script>

<style scoped>

</style>
