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
        v-model="form"
        @submit="form.post($routes.users())"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <loading-button
            :loading="form.processing"
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
  components: {
    LoadingButton,
    UserForm,
  },
  layout: Layout,
  props: {
    user: {
      type: Object,
      required: true,
    },
  },
  remember: 'form',
  data() {
    return {
      form: this.$inertia.form({
        user: this.user,
      }),
    }
  },
}
</script>
