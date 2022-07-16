<template>
  <div>
    <Head title="Create Contact" />
    <h1 class="mb-8 text-3xl font-bold">
      <Link
        class="text-indigo-400 hover:text-indigo-600"
        :href="$routes.contacts()"
      >
        Contacts
      </Link>
      <span class="font-medium text-indigo-400">/</span> Create
    </h1>
    <div class="max-w-3xl overflow-hidden rounded bg-white shadow">
      <contact-form
        v-model="form"
        :organizations="organizations"
        @submit="form.post($routes.contacts())"
      >
        <div
          class="flex items-center justify-end border-t border-gray-200 bg-gray-100 px-8 py-4"
        >
          <loading-button
            :loading="form.processing"
            class="btn-indigo"
            type="submit"
          >
            Create Contact
          </loading-button>
        </div>
      </contact-form>
    </div>
  </div>
</template>

<script>
import { Head, Link } from '@inertiajs/inertia-vue3';
import Layout from '@/Layouts/Main.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import ContactForm from './Form.vue';

export default {
  components: {
    Head,
    Link,
    LoadingButton,
    ContactForm,
  },
  layout: Layout,
  props: {
    organizations: {
      type: Array,
      required: true,
    },
  },
  remember: 'form',
  data() {
    return {
      form: this.$inertia.form({
        contact: {},
      }),
    };
  },
};
</script>
