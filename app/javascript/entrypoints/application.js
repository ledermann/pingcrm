// This file is automatically compiled by Vite, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import '~/styles/application.css';

import { createApp, h } from 'vue';

import { router, createInertiaApp } from '@inertiajs/vue3';
import { init, track } from '@plausible-analytics/tracker';
const plausibleUrl = document.querySelector(
  'meta[name="plausible-url"]',
).content;
if (plausibleUrl) {
  init({
    domain: document.querySelector('meta[name="app-host"]').content,
    endpoint: plausibleUrl,
    origin: globalThis.location.origin,
    autoCapturePageviews: false,
    outboundLinks: true,
  });

  router.on('navigate', () => {
    track('pageview', {});
  });
}

import * as Routes from '@/routes.js';

const pages = import.meta.glob('../Pages/**/*.vue', { eager: true });

createInertiaApp({
  resolve: (name) => {
    const component = pages[`../Pages/${name}.vue`];
    if (!component)
      throw new Error(
        `Unknown page ${name}. Is it located under Pages with a .vue extension?`,
      );

    return component;
  },

  title: (title) => (title ? `${title} - Ping CRM` : 'Ping CRM'),

  setup({ el, App, props, plugin }) {
    const vueApp = createApp({
      render: () => h(App, props),
    });
    vueApp.config.globalProperties.$routes = Routes;
    vueApp.use(plugin).mount(el);
  },
});
