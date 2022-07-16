<template>
  <div>
    <Head :title="`${form.contact.first_name} ${form.contact.last_name}`" />
    <h1 class="mb-8 text-3xl font-bold">
      <Link
        class="text-indigo-500 hover:text-indigo-800"
        :href="$routes.contacts()"
      >
        Contacts
      </Link>
      <span class="font-medium text-indigo-400">/</span>
      {{ form.contact.first_name }} {{ form.contact.last_name }}
    </h1>
    <trashed-message v-if="contact.deleted_at" class="mb-6" @restore="restore">
      This contact has been deleted.
    </trashed-message>
    <div class="max-w-3xl overflow-hidden rounded bg-white shadow">
      <contact-form
        v-model="form"
        :organizations="organizations"
        @submit="form.put($routes.contact(contact.id))"
      >
        <div
          class="flex items-center border-t border-gray-200 bg-gray-100 px-8 py-4"
        >
          <button
            v-if="!contact.deleted_at"
            class="text-red-700 hover:underline"
            tabindex="-1"
            type="button"
            @click="destroy"
          >
            Delete Contact
          </button>
          <loading-button
            :loading="form.processing"
            class="btn-indigo ml-auto"
            type="submit"
          >
            Update Contact
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
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import omit from 'lodash/omit';

export default {
  components: {
    Head,
    Link,
    LoadingButton,
    ContactForm,
    TrashedMessage,
  },
  layout: Layout,
  props: {
    contact: {
      type: Object,
      required: true,
    },
    organizations: {
      type: Array,
      required: true,
    },
  },
  remember: 'form',
  data() {
    return {
      form: this.$inertia.form({
        contact: omit(this.contact, 'id', 'deleted_at'),
      }),
    };
  },
  methods: {
    destroy() {
      if (confirm('Are you sure you want to delete this contact?')) {
        this.$inertia.delete(this.$routes.contact(this.contact.id));
      }
    },
    restore() {
      if (confirm('Are you sure you want to restore this contact?')) {
        this.$inertia.put(this.$routes.restore_contact(this.contact.id));
      }
    },
  },
};
</script>
