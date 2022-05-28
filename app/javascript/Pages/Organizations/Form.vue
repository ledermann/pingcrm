<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-8 -mr-6 -mb-8 flex flex-wrap">
      <text-input
        v-model="form.organization.name"
        :errors="form.errors.name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Name"
      />
      <text-input
        v-model="form.organization.email"
        :errors="form.errors.email"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Email"
      />
      <text-input
        v-model="form.organization.phone"
        :errors="form.errors.phone"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Phone"
      />
      <text-input
        v-model="form.organization.address"
        :errors="form.errors.address"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Address"
      />
      <text-input
        v-model="form.organization.city"
        :errors="form.errors.city"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="City"
      />
      <text-input
        v-model="form.organization.region"
        :errors="form.errors.region"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Province/State"
      />
      <select-input
        v-model="form.organization.country"
        :errors="form.errors.country"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Country"
      >
        <option :value="null" />
        <option value="CA">
          Canada
        </option>
        <option value="US">
          United States
        </option>
      </select-input>
      <text-input
        v-model="form.organization.postal_code"
        :errors="form.errors.postal_code"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Postal code"
      />
    </div>
    <slot />
  </form>
</template>

<script>
import SelectInput from '@/Shared/SelectInput.vue'
import TextInput from '@/Shared/TextInput.vue'

export default {
  components: {
    SelectInput,
    TextInput,
  },
  props: {
    value: {
      type: Object,
      required: true,
    },
  },
  computed: {
    form: {
      get() {
        return this.value
      },
      set(val) {
        this.$emit('input', val)
      },
    },
  },
}
</script>
