/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue';
import Vuex from 'vuex';
import VueResource from 'vue-resource';
import VueCanCan from 'vue-cancan';
import VueI18n from 'vue-i18n';
import Vuelidate from 'vuelidate';
import store from './store';
import Comments from './components/Comments.vue';
import Comment from './components/Comment.vue';
import PostsIndex from './components/admin/PostsIndex.vue';
import PostEdit from './components/admin/PostEdit.vue';


if (process.env.NODE_ENV !== 'production') {
  Vue.config.devtools = true;
}

Vue.use(TurbolinksAdapter);
Vue.use(VueResource);
Vue.use(Vuex);
Vue.use(VueI18n);
Vue.use(Vuelidate);

if(typeof gon !== 'undefined') {
  Vue.use(VueCanCan, {rules: gon.abilities.rules});
}
export const eventBus = new Vue();

document.addEventListener('turbolinks:load', () => {
  if (process.env.NODE_ENV !== 'test') {
    Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }

  // Create VueI18n instance with options
  const i18n = new VueI18n({
    locale: document.querySelector('body').getAttribute('data-locale'), // set locale
    messages: window.I18n.translations, // set locale messages
  });

  const commentsEl = document.getElementById('vue-comments-elem');

  if (commentsEl !== null) {
    const comments = JSON.parse(commentsEl.dataset.comments);
    const postId = JSON.parse(commentsEl.dataset.postId);
    const postComments = new Vue({
      el: commentsEl,
      store,
      components: {
        appComments: Comments,
      },
      data() {
        return {
          comments,
          postId,
        };
      },
      i18n,
    });
  }

  const commentEl = document.getElementById('vue-comment-elem');

  if (commentEl !== null) {
    const comment = JSON.parse(commentEl.dataset.comment);
    const showComment = new Vue({
      el: commentEl,
      store,
      components: {
        appComment: Comment,
      },
      data() {
        return {
          comment,
        };
      },
      i18n,
    });
  }

  const editCommentEl = document.getElementById('vue-edit-comment-elem');

  if (editCommentEl !== null) {
    const comment = JSON.parse(editCommentEl.dataset.comment);
    const editComment = new Vue({
      el: editCommentEl,
      store,
      components: {
        appComment: Comment,
      },
      data() {
        return {
          comment,
        };
      },
      i18n,
    });
  }

  const postsEl = document.getElementById('vue-elem');

  if (postsEl !== null) {
    const posts = JSON.parse(postsEl.dataset.posts);
    const adminPostsIndex = new Vue({
      el: postsEl,
      store,
      components: {
        PostsIndex,
      },
      data() {
        return {
          posts,
        };
      },
      i18n,
    });
  }

  const postEl = document.getElementById('vue-post-edit-elem');

  if (postEl !== null) {
    const post = JSON.parse(postEl.dataset.post);
    const adminPostEdit = new Vue({
      el: postEl,
      store,
      components: {
        PostEdit,
      },
      data() {
        return {
          post,
        };
      },
      i18n,
    });
  }
});


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the using turbolinks, install 'vue-turbolinks':
//
// yarn add 'vue-turbolinks'
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
