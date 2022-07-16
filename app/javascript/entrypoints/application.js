// This file is automatically compiled by Vite, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import '~/styles/application.css';

import { createApp, h } from 'vue';

import { Inertia } from '@inertiajs/inertia';
import Plausible from 'plausible-tracker';
const plausibleUrl = document.querySelector(
  'meta[name="plausible-url"]',
).content;
if (plausibleUrl) {
  const plausible = Plausible({
    domain: document.querySelector('meta[name="app-host"]').content,
    apiHost: plausibleUrl,
  });

  Inertia.on('navigate', () => {
    plausible.trackPageview();
  });
}

import { createInertiaApp } from '@inertiajs/inertia-vue3';
import { InertiaProgress } from '@inertiajs/progress';
InertiaProgress.init();

import * as Routes from '@/utils/routes.js';

const pages = import.meta.globEagerDefault('../Pages/**/*.vue');

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
