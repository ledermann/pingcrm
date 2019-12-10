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
        :form="form"
        :organizations="organizations"
        @submit="submit"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button
            :loading="sending"
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
import Layout from '@/Shared/Layout'
import LoadingButton from '@/Shared/LoadingButton'
import ContactForm from './Form'

export default {
  metaInfo: { title: 'Create Contact' },
  layout: (h, page) => h(Layout, [page]),
  components: {
    LoadingButton,
    ContactForm,
  },
  props: {
    organizations: {
      type: Array,
      required: true,
    },
  },
  remember: 'form',
  data() {
    return {
      sending: false,
      form: { last_name: null },
    }
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia
        .post(this.$routes.contacts(), this.form)
        .then(() => (this.sending = false))
    },
  },
}
</script>
