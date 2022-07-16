<template>
  <div
    class="flex min-h-screen items-center justify-center bg-indigo-800 p-5 text-indigo-100"
  >
    <Head title="Error" />
    <div class="w-full max-w-md">
      <h1 class="text-3xl">
        {{ title }}
      </h1>
      <p class="mt-3 text-lg leading-tight">
        {{ description }}
      </p>
    </div>
  </div>
</template>

<script>
import { Head } from '@inertiajs/inertia-vue3';

export default {
  components: {
    Head,
  },
  props: {
    status: {
      type: Number,
      required: true,
    },
  },
  computed: {
    title() {
      return {
        403: '403: Forbidden',
        404: '404: Page Not Found',
        500: '500: Server Error',
        503: '503: Service Unavailable',
      }[this.status];
    },
    description() {
      return {
        403: 'Sorry, you are forbidden from accessing this page.',
        404: 'Sorry, the page you are looking for could not be found.',
        500: 'Whoops, something went wrong on our servers.',
        503: 'Sorry, we are doing some maintenance. Please check back soon.',
      }[this.status];
    },
  },
};
</script>
