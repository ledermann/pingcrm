<template>
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <inertia-link
        class="text-indigo-400 hover:text-indigo-600"
        :href="$routes.contacts()"
      >
        Contacts
      </inertia-link>
      <span class="text-indigo-400 font-medium">/</span> Create
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <contact-form
        v-model="form"
        :organizations="organizations"
        @submit="form.post($routes.contacts())"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
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
import Layout from '@/Layouts/Main.vue'
import LoadingButton from '@/Shared/LoadingButton.vue'
import ContactForm from './Form.vue'

export default {
  metaInfo: { title: 'Create Contact' },
  components: {
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
    }
  },
}
</script>
