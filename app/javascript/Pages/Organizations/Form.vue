<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-8 -mr-6 -mb-8 flex flex-wrap">
      <text-input
        v-model="form.name"
        :errors="$page.errors.name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Name"
      />
      <text-input
        v-model="form.email"
        :errors="$page.errors.email"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Email"
      />
      <text-input
        v-model="form.phone"
        :errors="$page.errors.phone"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Phone"
      />
      <text-input
        v-model="form.address"
        :errors="$page.errors.address"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Address"
      />
      <text-input
        v-model="form.city"
        :errors="$page.errors.city"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="City"
      />
      <text-input
        v-model="form.region"
        :errors="$page.errors.region"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Province/State"
      />
      <select-input
        v-model="form.country"
        :errors="$page.errors.country"
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
        v-model="form.postal_code"
        :errors="$page.errors.postal_code"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Postal code"
      />
    </div>
    <slot />
  </form>
</template>

<script>
import SelectInput from '@/Shared/SelectInput'
import TextInput from '@/Shared/TextInput'

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
