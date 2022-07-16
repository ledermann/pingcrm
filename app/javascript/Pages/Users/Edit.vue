<template>
  <div>
    <Head :title="`${form.user.first_name} ${form.user.last_name}`" />
    <div class="mb-8 flex max-w-3xl justify-start">
      <h1 class="text-3xl font-bold">
        <Link
          class="text-indigo-500 hover:text-indigo-600"
          :href="$routes.users()"
        >
          Users
        </Link>
        <span class="font-medium text-indigo-400">/</span>
        {{ form.user.first_name }} {{ form.user.last_name }}
      </h1>
      <img
        v-if="user.photo"
        class="ml-4 block h-8 w-8 rounded-full"
        :src="user.photo"
        alt="Photo"
      />
    </div>
    <trashed-message v-if="user.deleted_at" class="mb-6" @restore="restore">
      This user has been deleted.
    </trashed-message>
    <div class="max-w-3xl overflow-hidden rounded bg-white shadow">
      <user-form v-model="form" @submit="submit">
        <div
          v-if="can.edit_user"
          class="flex items-center border-t border-gray-200 bg-gray-100 px-8 py-4"
        >
          <button
            v-if="!user.deleted_at"
            class="text-red-800 hover:underline"
            tabindex="-1"
            type="button"
            @click="destroy"
          >
            Delete User
          </button>
          <loading-button
            :loading="form.processing"
            class="btn-indigo ml-auto"
            type="submit"
          >
            Update User
          </loading-button>
        </div>
      </user-form>
    </div>
  </div>
</template>

<script>
import { Head, Link } from '@inertiajs/inertia-vue3';
import Layout from '@/Layouts/Main.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import UserForm from './Form.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';

export default {
  components: {
    Head,
    Link,
    LoadingButton,
    UserForm,
    TrashedMessage,
  },
  layout: Layout,
  props: {
    user: {
      type: Object,
      required: true,
    },
    can: {
      type: Object,
      required: true,
    },
  },
  remember: 'form',
  data() {
    return {
      form: this.$inertia.form({
        user: {
          ...this.user,
          photo: null,
        },
      }),
    };
  },
  methods: {
    submit() {
      this.form.put(this.$routes.user(this.user.id), {
        onSuccess: () => this.form.reset('password', 'photo'),
      });
    },
    destroy() {
      if (confirm('Are you sure you want to delete this user?')) {
        this.$inertia.delete(this.$routes.user(this.user.id));
      }
    },
    restore() {
      if (confirm('Are you sure you want to restore this user?')) {
        this.$inertia.put(this.$routes.restore_user(this.user.id));
      }
    },
  },
};
</script>
