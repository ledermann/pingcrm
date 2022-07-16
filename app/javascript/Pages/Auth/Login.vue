<template>
  <div class="flex min-h-screen items-center justify-center bg-indigo-800 p-6">
    <Head title="Login" />
    <div class="w-full max-w-md">
      <logo class="mx-auto block w-full max-w-xs fill-white" height="50" />
      <form
        class="mt-8 overflow-hidden rounded-lg bg-white shadow-xl"
        @submit.prevent="form.post($routes.user_session())"
      >
        <div class="px-10 py-12">
          <flash-messages />

          <h1 class="text-center text-3xl font-bold">Welcome Back!</h1>
          <div class="mx-auto mt-6 w-24 border-b-2" />
          <text-input
            v-model="form.user.email"
            class="mt-10"
            label="Email"
            type="email"
            autofocus
            autocapitalize="off"
          />
          <text-input
            v-model="form.user.password"
            class="mt-6"
            label="Password"
            type="password"
          />
          <label class="mt-6 flex select-none items-center" for="remember">
            <input
              id="remember"
              v-model="form.user.remember_me"
              class="mr-1"
              type="checkbox"
            />
            <span class="text-sm">Remember Me</span>
          </label>
        </div>
        <div
          class="flex items-center justify-between border-t border-gray-200 bg-gray-100 px-10 py-4"
        >
          <a class="hover:underline" tabindex="-1" href="#reset-password"
            >Forgot password?</a
          >
          <loading-button
            :loading="form.processing"
            class="btn-indigo"
            type="submit"
          >
            Login
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { Head } from '@inertiajs/inertia-vue3';
import Layout from '@/Layouts/Minimal.vue';
import FlashMessages from '@/Shared/FlashMessages.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import Logo from '@/Shared/Logo.vue';
import TextInput from '@/Shared/TextInput.vue';

export default {
  components: {
    Head,
    FlashMessages,
    LoadingButton,
    Logo,
    TextInput,
  },
  layout: Layout,
  data() {
    return {
      form: this.$inertia.form({
        user: {
          email: 'johndoe@example.com',
          password: 'secret',
          remember_me: null,
        },
      }),
    };
  },
};
</script>
