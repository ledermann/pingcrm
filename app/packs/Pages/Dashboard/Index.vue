<template>
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      Dashboard
    </h1>
    <p class="mb-8 leading-normal">
      Hey there! Welcome to Ping CRM, a demo app designed to help illustrate how
      <a
        class="text-indigo-800 underline hover:text-orange-600 font-bold"
        href="https://inertiajs.com"
      >
        Inertia.js
      </a> works with
      <a
        href="https://rubyonrails.org/"
        class="text-indigo-800 underline hover:text-orange-600 font-bold"
      >
        Ruby on Rails
      </a>.
    </p>

    <p
      v-if="git.commit_url"
      class="mb-10 leading-normal"
    >
      Version
      <a
        :href="git.commit_url"
        class="hover:underline"
      >
        {{ git.commit_sha }}
      </a>
      &minus;
      {{ relativeCommitTime }}
    </p>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import * as timeago from 'timeago.js'

export default {
  metaInfo: { title: 'Dashboard' },
  layout: Layout,
  props: {
    git: {
      type: Object,
      required: true,
    },
  },
  computed: {
    relativeCommitTime() {
      return timeago.format(this.git.commit_time)
    },
  },
}
</script>
