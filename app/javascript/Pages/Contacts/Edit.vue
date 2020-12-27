<template>
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <inertia-link
        class="text-indigo-500 hover:text-indigo-800"
        :href="$routes.contacts()"
      >
        Contacts
      </inertia-link>
      <span class="text-indigo-400 font-medium">/</span>
      {{ form.contact.first_name }} {{ form.contact.last_name }}
    </h1>
    <trashed-message
      v-if="contact.deleted_at"
      class="mb-6"
      @restore="restore"
    >
      This contact has been deleted.
    </trashed-message>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <contact-form
        v-model="form"
        :organizations="organizations"
        @submit="form.put($routes.contact(contact.id))"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
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
import Layout from '@/Layouts/Main'
import LoadingButton from '@/Shared/LoadingButton'
import ContactForm from './Form'
import TrashedMessage from '@/Shared/TrashedMessage'
import _ from 'lodash'

export default {
  metaInfo() {
    return {
      title: `${this.form.contact.first_name} ${this.form.contact.last_name}`,
    }
  },
  components: {
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
        contact: _.omit(this.contact, 'id', 'deleted_at'),
      }),
    }
  },
  methods: {
    destroy() {
      if (confirm('Are you sure you want to delete this contact?')) {
        this.$inertia.delete(this.$routes.contact(this.contact.id))
      }
    },
    restore() {
      if (confirm('Are you sure you want to restore this contact?')) {
        this.$inertia.put(this.$routes.restore_contact(this.contact.id))
      }
    },
  },
}
</script>
