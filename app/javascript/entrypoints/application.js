// This file is automatically compiled by Vite, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Vue from 'vue'
import VueMeta from 'vue-meta'
Vue.use(VueMeta)

import PortalVue from 'portal-vue'
Vue.use(PortalVue)

import MatomoTracker from '@/utils/matomo-tracker'
import { Inertia } from '@inertiajs/inertia'
Vue.use(MatomoTracker)
if (Vue.matomo.enabled)
  Inertia.on('navigate', () => {
    Vue.matomo.trackPageView()
  })

import { createInertiaApp } from '@inertiajs/inertia-vue'
import { Head, Link } from '@inertiajs/inertia-vue'
import { InertiaProgress } from '@inertiajs/progress'
Vue.component('InertiaHead', Head)
Vue.component('InertiaLink', Link)
InertiaProgress.init()

import * as Routes from '@/utils/routes.js'
Vue.prototype.$routes = Routes

const pages = import.meta.globEagerDefault('../Pages/**/*.vue')

createInertiaApp({
  resolve: name => {
    const component = pages[`../Pages/${name}.vue`]
    if (!component)
      throw new Error(
        `Unknown page ${name}. Is it located under Pages with a .vue extension?`,
      )

    return component
  },

  setup({ el, app, props, plugin }) {
    Vue.use(plugin)

    new Vue({
      metaInfo: {
        titleTemplate: (title) => title ? `${title} - PingCRM` : 'PingCRM',
      },
      render: h => h(app, props),
    }).$mount(el)
  },
})
