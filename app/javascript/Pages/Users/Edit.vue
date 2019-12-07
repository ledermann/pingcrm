<template>
  <div>
    <div class="mb-8 flex justify-start max-w-3xl">
      <h1 class="font-bold text-3xl">
        <inertia-link class="text-indigo-500 hover:text-indigo-600" :href="$routes.users()">Users</inertia-link>
        <span class="text-indigo-400 font-medium">/</span>
        {{ form.first_name }} {{ form.last_name }}
      </h1>
      <img v-if="user.photo" class="block w-8 h-8 rounded-full ml-4" :src="user.photo" alt="Photo">
    </div>
    <trashed-message v-if="user.deleted_at" class="mb-6" @restore="restore">
      This user has been deleted.
    </trashed-message>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <user-form @submit="submit" :form="form">
        <div v-if="can.edit_user" class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <button v-if="!user.deleted_at" class="text-red-800 hover:underline" tabindex="-1" type="button" @click="destroy">Delete User</button>
          <loading-button :loading="sending" class="btn-indigo ml-auto" type="submit">Update User</loading-button>
        </div>
      </user-form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Shared/Layout'
import LoadingButton from '@/Shared/LoadingButton'
import UserForm from './Form'
import TrashedMessage from '@/Shared/TrashedMessage'

export default {
  metaInfo() {
    return {
      title: `${this.form.first_name} ${this.form.last_name}`
    }
  },
  layout: (h, page) => h(Layout, [page]),
  components: {
    LoadingButton,
    UserForm,
    TrashedMessage
  },
  props: {
    user: Object,
    can: Object
  },
  remember: 'form',
  data() {
    return {
      sending: false,
      form: {
        first_name: this.user.first_name,
        last_name: this.user.last_name,
        email: this.user.email,
        password: this.user.password,
        owner: this.user.owner,
        photo: null
      }
    }
  },
  methods: {
    submit() {
      this.sending = true

      var data = new FormData()
      data.append('user[first_name]', this.form.first_name || '')
      data.append('user[last_name]', this.form.last_name || '')
      data.append('user[email]', this.form.email || '')
      data.append('user[password]', this.form.password || '')
      data.append('user[owner]', this.form.owner ? '1' : '0')
      data.append('user[photo]', this.form.photo || '')
      data.append('_method', 'put')

      this.$inertia.post(this.$routes.user(this.user.id), data).then(() => {
        this.sending = false
        if (Object.keys(this.$page.errors).length === 0) {
          this.form.photo = null
          this.form.password = null
        }
      })
    },
    destroy() {
      if (confirm('Are you sure you want to delete this user?')) {
        this.$inertia.delete(this.$routes.user(this.user.id))
      }
    },
    restore() {
      if (confirm('Are you sure you want to restore this user?')) {
        this.$inertia.put(this.$routes.restore_user(this.user.id))
      }
    }
  }
}
</script>
