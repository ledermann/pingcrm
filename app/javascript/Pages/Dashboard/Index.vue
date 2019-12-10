<template>
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      Dashboard
    </h1>
    <p class="mb-12 leading-normal">
      Hey there! Welcome to Ping CRM, a demo app designed to help illustrate how
      <a
        class="text-indigo-700 underline hover:text-orange-600"
        href="https://github.com/inertiajs"
      >
        Inertia.js
      </a> works.
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
      <br>
      Built at
      <span class="ml-1 text-gray-700">
        {{ git.commit_time }}
      </span>
    </p>

    <div>
      <inertia-link
        class="btn-indigo"
        :href="$routes.error_500()"
      >
        500 error
      </inertia-link>
      <inertia-link
        class="ml-2 btn-indigo"
        href="/error-404"
      >
        404 error
      </inertia-link>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout'

export default {
  metaInfo: { title: 'Dashboard' },
  layout: Layout,
  props: {
    git: {
      type: Object,
      required: true,
    },
  },
}
</script>
