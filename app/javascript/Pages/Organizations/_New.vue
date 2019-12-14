<template>
  <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
    <div class="px-8 py-4 bg-gray-100 border-b border-gray-200">
      <h1 class="font-bold text-xl">
        Create Organization
      </h1>
    </div>

    <organization-form
      :form="form"
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
  </div>
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
