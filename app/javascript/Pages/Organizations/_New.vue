<template>
  <organization-form v-model="form" class="max-w-3xl bg-white" @submit="submit">
    <div
      class="flex items-center justify-end border-t border-gray-200 bg-gray-100 px-8 py-4"
    >
      <loading-button
        :loading="form.processing"
        class="btn-indigo"
        type="submit"
      >
        Create Organization
      </loading-button>
    </div>
  </organization-form>
</template>

<script>
import LoadingButton from '@/Shared/LoadingButton.vue';
import OrganizationForm from './Form.vue';

export default {
  components: {
    LoadingButton,
    OrganizationForm,
  },
  remember: 'form',
  emits: ['success'],
  data() {
    return {
      form: this.$inertia.form({
        organization: {},
      }),
    };
  },
  methods: {
    submit() {
      this.form.post(this.$routes.organizations(), {
        onSuccess: () => {
          this.$emit('success');
          this.form.reset('organization');
        },
      });
    },
  },
};
</script>
