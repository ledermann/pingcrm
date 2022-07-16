<template>
  <div>
    <Head title="Create User" />
    <h1 class="mb-8 text-3xl font-bold">
      <Link
        class="text-indigo-400 hover:text-indigo-600"
        :href="$routes.users()"
      >
        Users
      </Link>
      <span class="font-medium text-indigo-400">/</span> Create
    </h1>
    <div class="max-w-3xl overflow-hidden rounded bg-white shadow">
      <user-form v-model="form" @submit="form.post($routes.users())">
        <div
          class="flex items-center justify-end border-t border-gray-200 bg-gray-100 px-8 py-4"
        >
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
import { Head, Link } from '@inertiajs/inertia-vue3';
import Layout from '@/Layouts/Main.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import UserForm from './Form.vue';

export default {
  components: {
    Head,
    Link,
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
    };
  },
};
</script>
