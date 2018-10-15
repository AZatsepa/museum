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
import Comments from './components/Comments.vue.erb';
import store from './store';
import PostsIndex from './components/admin/PostsIndex.vue.erb';

Vue.use(TurbolinksAdapter);
Vue.use(VueResource);
Vue.use(Vuex);

Vue.use(VueCanCan, { rules: gon.abilities.rules});

export const eventBus = new Vue();

document.addEventListener('turbolinks:load', () => {
  if (process.env.NODE_ENV !== 'test') {
    Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }

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
