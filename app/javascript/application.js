// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import './styles/application.css'

// Uncomment to copy all static images under ./images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
require.context('./images', true)
// const imagePath = (name) => images(name, true)

import Vue from 'vue'
import VueMeta from 'vue-meta'
Vue.use(VueMeta)

import PortalVue from 'portal-vue'
Vue.use(PortalVue)

import MatomoTracker from '@/utils/matomo-tracker'
Vue.use(MatomoTracker)

import { createInertiaApp } from '@inertiajs/inertia-vue'
import { Head, Link } from '@inertiajs/inertia-vue'
import { InertiaProgress } from '@inertiajs/progress'
Vue.component('InertiaHead', Head)
Vue.component('InertiaLink', Link)
InertiaProgress.init()

import * as Routes from '@/utils/routes.js'
Vue.prototype.$routes = Routes

createInertiaApp({
  resolve: name => import(`@/Pages/${name}`).then(({ default: component }) => {
    if (Vue.matomo.enabled)
      // Wait a bit to allow VueMeta to update the document.title
      setTimeout(() => {
        Vue.matomo.trackPageView()
      }, 100)

    return component
  }),

  setup({ el, app, props }) {
    new Vue({
      metaInfo: {
        titleTemplate: (title) => title ? `${title} - PingCRM` : 'PingCRM',
      },
      render: h => h(app, props),
    }).$mount(el)
  },
})
