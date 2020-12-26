<template>
  <organization-form
    v-model="form"
    class="bg-white max-w-3xl"
    @submit="submit"
  >
    <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
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
import LoadingButton from '@/Shared/LoadingButton'
import OrganizationForm from './Form'

export default {
  components: {
    LoadingButton,
    OrganizationForm,
  },
  remember: 'form',
  data() {
    return {
      form: this.$inertia.form({
        organization: {},
      }),
    }
  },
  methods: {
    submit() {
      this.form.post(this.$routes.organizations(), {
        onSuccess: () => {
          this.$emit('success')
          this.form.reset('organization')
        },
      })
    },
  },
}
</script>
