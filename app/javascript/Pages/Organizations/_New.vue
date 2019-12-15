<template>
  <organization-form
    :form="form"
    class="bg-white max-w-3xl"
    @submit="submit"
  >
    <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
      <loading-button
        :loading="sending"
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
      sending: false,
      form: {},
    }
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia.post(this.$routes.organizations(), this.form).then(() => {
        this.sending = false
        if (Object.keys(this.$page.errors).length === 0) {
          this.form = {}
          this.$emit('success')
        }
      })
    },
  },
}
</script>
