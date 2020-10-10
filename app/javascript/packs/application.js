// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import '../styles/application.scss'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from 'vue'
import VueMeta from 'vue-meta'
Vue.use(VueMeta)

import PortalVue from 'portal-vue'
Vue.use(PortalVue)

import MatomoTracker from '@/utils/matomo-tracker'
Vue.use(MatomoTracker)

import { app, plugin } from '@inertiajs/inertia-vue'
import { InertiaProgress as progress } from '@inertiajs/progress'
Vue.use(plugin)
progress.init()

import Routes from '@/utils/routes.js'
Vue.prototype.$routes = Routes

const el = document.getElementById('app')

new Vue({
  metaInfo: {
    titleTemplate: (title) => title ? `${title} - PingCRM` : 'PingCRM',
  },
  render: h => h(app, {
    props: {
      initialPage: JSON.parse(el.dataset.page),
      resolveComponent: name => import(`@/Pages/${name}`).then(module => module.default),
      transformProps: props => {
        if (Vue.matomo.enabled)
          // Wait a bit to allow VueMeta to update the document.title
          setTimeout(() => {
            Vue.matomo.trackPageView()
          }, 100)

        return props
      },
    },
  }),
}).$mount(el)
