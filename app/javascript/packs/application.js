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

import axios from 'axios'

// Tell Axios to send the CSRF token (taken from the cookie)
// in the header named as "X-CSRF-Token", as this is the name
// expected by Rails
axios.defaults.xsrfHeaderName = 'X-CSRF-Token'

import MatomoTracker from '@/utils/matomo-tracker'
const matomo = new MatomoTracker()

import Notifications from 'vue-notification'
Vue.use(Notifications)

function handleNotications(props) {
  setTimeout(() => {
    if (props.flash.success) {
      Vue.notify({
        group: 'default',
        text: props.flash.success,
        type: 'success',
      })
    } else if (props.flash.alert) {
      Vue.notify({
        group: 'default',
        text: props.flash.alert,
        type: 'error',
      })
    } else if (Object.keys(props.errors).length === 1) {
      Vue.notify({
        group: 'default',
        text: 'There is one form error.',
        type: 'error',
      })
    } else if (Object.keys(props.errors).length > 1) {
      Vue.notify({
        group: 'default',
        text: `There are ${Object.keys(props.errors).length} form errors.`,
        type: 'error',
      })
    }
  }, 100)
}

import { InertiaApp } from '@inertiajs/inertia-vue'
Vue.use(InertiaApp)

import Routes from '@/utils/routes.js'
Vue.prototype.$routes = Routes

const app = document.getElementById('app')

new Vue({
  metaInfo: {
    title: 'Loading…',
    titleTemplate: '%s | PingCRM',
  },
  render: h => h(InertiaApp, {
    props: {
      initialPage: JSON.parse(app.dataset.page),
      resolveComponent: name => import(`@/Pages/${name}`).then(module => module.default),
      transformProps: props => {
        handleNotications(props)

        if (matomo.enabled)
          // Wait a bit to allow VueMeta to update the document.title
          setTimeout(() => {
            matomo.trackPageView()
          }, 100)

        return props
      },
    },
  }),
}).$mount(app)
