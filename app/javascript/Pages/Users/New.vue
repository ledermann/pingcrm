<template>
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <inertia-link
        class="text-indigo-400 hover:text-indigo-600"
        :href="$routes.users()"
      >
        Users
      </inertia-link>
      <span class="text-indigo-400 font-medium">/</span> Create
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <user-form
        :form="form"
        @submit="submit"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button
            :loading="sending"
            class="btn-indigo"
            type="submit"
          >
            Create User
          </loading-button>
        </div>
      </user-form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import LoadingButton from '@/Shared/LoadingButton'
import UserForm from './Form'

export default {
  metaInfo: { title: 'Create User' },
  layout: Layout,
  components: {
    LoadingButton,
    UserForm,
  },
  props: {
    user: {
      type: Object,
      required: true,
    },
  },
  remember: 'form',
  data() {
    return {
      sending: false,
      form: this.user,
    }
  },
  methods: {
    submit() {
      this.sending = true

      let data = new FormData()
      data.append('user[first_name]', this.form.first_name || '')
      data.append('user[last_name]', this.form.last_name || '')
      data.append('user[email]', this.form.email || '')
      data.append('user[password]', this.form.password || '')
      data.append('user[owner]', this.form.owner ? '1' : '0')
      data.append('user[photo]', this.form.photo || '')

      this.$inertia
        .post(this.$routes.users(), data)
        .then(() => (this.sending = false))
    },
  },
}
</script>
