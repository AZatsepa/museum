<template>
    <div class="row text-left">
      <form class="new_comment" id="new_comment" >
        <div class="form-group" :class="{invalid: $v.myComment.text.$error}">
          <label for="new_comment_text">
            {{ $t('titles.comments.text') }}:
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
          <small class="text-danger" v-if="$v.myComment.text.$error">{{$t('errors.blank')}}</small>
          <div v-for="(image, index) in myComment.images"
                              class="attachments"
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
          <a class="add_comment_attachment" @click.prevent="showImageInput = !showImageInput">
            {{ $t('titles.attachments.add') }}
          </a>
        </div>

        <button class="btn"
                data-disable-with="Збереження..."
                @click.prevent="createComment"
                :disabled="$v.$invalid">
          {{ $t('titles.comments.add') }}
        </button>
      </form>
    </div>
</template>

<script>
  import objectToFormData from '../shared/object_to_form_data';
  import { required } from 'vuelidate/lib/validators';

  export default {
    props: ['comment'],
    name: 'NewCommentForm',
    data() {
      return {
        myComment: this.comment,
        errors: [],
        showImageInput: false
      };
    },
    validations: {
      myComment: {
        text: {
          required,
        },
      },
    },
    methods: {
      updateComment() {
        const comment = objectToFormData(this.comment, null, 'comment');
        this.$http.patch(`/${this.$i18n.locale}/posts/${this.post_id}/comments/${this.comment.id}`, comment).then((response) => {
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
</style>
