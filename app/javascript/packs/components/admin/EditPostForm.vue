<template>
    <div class="d-flex justify-content-center align-items-center container">
      <div class="markdown" id="post_form">
        <form class="new_post" style="display: block;">
          <div class="form-group text-center align-items-center justify-content-center">
            <div :class="{ invalid: $v.myPost.title.$error }">
              <label class="control-label">
                {{ $t('titles.posts.title') }}
              </label>
              <input class="form-control"
                     type="text"
                     v-model="myPost.title"
                     id="post_title"
                     @input="$v.myPost.title.$touch()">
              <small class="text-danger" v-if="$v.myPost.title.$error">{{$t('errors.blank')}}</small>
            </div>
            <div class="form-group text-center align-items-center justify-content-center"
                 :class="{ invalid: $v.myPost.body.$error }">
              <label class="control-label" for="post_body">{{ $t('titles.posts.body') }}</label>
              <textarea class="form-control" v-model="myPost.body" id="post_body" @input="$v.myPost.body.$touch()">
              </textarea>
              <small class="text-danger" v-if="$v.myPost.body.$error">{{$t('errors.blank')}}</small>
            </div>
            <div v-for="(image, index) in myPost.images"
                                          class="attachments"
                                          :image="image"
                                          :key="index">
              <div>
                <div class="custom-file">
                  <input type="file"
                         class="custom-file-input"
                         :id="`post_attachment_${index}`"
                         @change="onImageSelected($event, image)">
                  <label class="custom-file-label">
                    {{ image.name }}
                  </label>
                </div>
                <button class="btn btn-sm btn-small btn-danger remove_file">
                  {{ $t('titles.attachments.delete') }}
                </button>
              </div>
            </div>
            <div class="attachments">
              <div>
                <div class="custom-file" v-if="showImageInput">
                  <input type="file"
                         class="custom-file-input"
                         @change="onImageSelected($event)">
                  <label class="custom-file-label">
                    {{ $t('choose_image') }}
                  </label>
                </div>
              </div>
            </div>
            <button class="btn btn-sm btn-dark add_post_attachment" id="add_file" @click.prevent="showInput">
              {{ $t('titles.attachments.add') }}
            </button>
            <div class="form-group">
              <button class="btn btn-success" @click.prevent="updatePost" :disabled="$v.$invalid">
                {{ $t('titles.posts.edit') }}
              </button>
              <button class="btn btn-danger cancel-btn" @click.prevent="cancelForm">
                {{ $t('cancel') }}
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
</template>

<script>
  import objectToFormData from '../../shared/object_to_form_data';
  import { required } from 'vuelidate/lib/validators';

  export default {
    props: ['post'],
    data() {
      return {
        myPost: {
          title: this.post.title,
          body: this.post.body,
          images: [],
          destroy_images: [],
        },
        showImageInput: false,
      };
    },
    validations: {
      myPost: {
        title: {
          required,
        },
        body: {
          required,
        },
      },
    },
    mounted() {
      $('#post_body').markItUp(this.$store.state.myHtmlSettings);
    },
    methods: {
      updatePost() {
        const post = objectToFormData(this.myPost, null, 'post');
        this.$http.patch(`/admin/posts/${this.post.id}`, post).then((response) => {
          Turbolinks.visit(response.headers.get('Location'))
        },
         (response) => {
          console.log(response);
        });
      },
      onImageSelected(event) {
        this.myPost.images.push(event.target.files[0]);
        this.showImageInput = false;
      },
      showInput() {
        this.showImageInput = true;
      },
      destroyImage(image) {
        this.myPost.destroy_images.push(image.id);
      },
      cancelForm() {
        Turbolinks.visit(`/admin/posts/${this.post.id}`);
      },
    },
  };
</script>

<style scoped>
  .invalid input {
      border-color: #cd0a0a;
  }

  .invalid label {
      color: #cd0a0a;
  }
</style>
