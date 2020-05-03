<template>
    <form class="new_comment" id="new_comment" >
        <div class="form-group" :class="{invalid: $v.comment.text.$error}">
          <label for="new_comment_text" class="font-weight-bold">
            {{ $t('titles.comments.text') }}
          </label>
          <div class="comment-errors">
            <span class="text-danger" v-for="(error, index) in errors" :key="index">
              {{error}}
            </span>
          </div>
          <textarea id="new_comment_text"
                    class="form-control form-control-lg"
                    rows="5"
                    v-model="comment.text"
                    @input="$v.comment.text.$touch()">
          </textarea>
          <small class="text-danger pt-2 d-block" v-if="$v.comment.text.$error">{{$t('errors.blank')}}</small>
          <div v-for="(image, index) in comment.images"
                              class="attachments mt-3"
                              :image="image"
                              :key="index">
              <div>
                <div class="custom-file">
                  <input type="file"
                         class="custom-file-input"
                         :id="`comment_attachment_${index}`"
                         @change="onImageSelected($event)">
                <label class="custom-file-label">
                  {{ image.name }}
                </label>
              </div>
              <button class="btn btn-sm btn-small btn-danger mt-2">
                {{ $t('titles.attachments.delete') }}
              </button>
            </div>
          </div>
          <div class="attachments">
            <div>
              <div class="custom-file mt-3" v-if="showImageInput">
                <input type="file"
                       class="custom-file-input"
                       @change="onImageSelected($event)">
                <label class="custom-file-label">
                  {{ $t('choose_image') }}
                </label>
              </div>
            </div>
          </div>
          <div class="mt-3">
              <button class="btn btn-default add_comment_attachment" @click.prevent="showImageInput = !showImageInput">
                  {{ $t('titles.attachments.add') }}
              </button>
          </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-3">
                <button class="btn btn-success btn-block"
                        :class="[$v.$invalid ? 'comment_add' : 'comment_add_active']"
                        data-disable-with="Збереження..."
                        @click.prevent="createComment">
                    {{ $t('titles.comments.add') }}
                </button>
            </div>
        </div>
      </form>
</template>

<script>
  import objectToFormData from '../shared/object_to_form_data';
  import { required } from 'vuelidate/lib/validators';

  export default {
    props: ['post_id'],
    name: 'NewCommentForm',
    data() {
      return {
        comment: {
          text: '',
          images: [],
        },
        errors: [],
        showImageInput: false,
      };
    },
    validations: {
      comment: {
        text: {
          required,
        },
      },
    },
    methods: {
      createComment() {
        const comment = objectToFormData(this.comment, null, 'comment');
        this.$http.post(`/${this.$i18n.locale}/posts/${this.post_id}/comments`, comment).then((response) => {
          this.comment = {
            text: '',
            images: [],
           };
        this.errors = [];
        },
         (response) => {
          this.errors = response.body;
        });
      },
      onImageSelected(event) {
        this.comment.images.push(event.target.files[0]);
        this.showImageInput = false;
      },
    },
  };
</script>

<style scoped>
    .invalid textarea {
        border-color: #cd0a0a;
    }

    .invalid label {
        color: #cd0a0a;
    }

    .comment_add {
        opacity: 0;
        visibility: hidden;
    }

    .comment_add_active {
        opacity: 1;
        visibility: visible;
    }
</style>
