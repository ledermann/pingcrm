<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-8 -mr-6 -mb-8 flex flex-wrap">
      <text-input
        v-model="form.contact.first_name"
        :errors="form.errors.first_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="First name"
      />
      <text-input
        v-model="form.contact.last_name"
        :errors="form.errors.last_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Last name"
      />
      <select-input
        v-model="form.contact.organization_id"
        :errors="form.errors.organization_id"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Organization"
      >
        <option :value="null" />
        <option
          v-for="organization in organizations"
          :key="organization.id"
          :value="organization.id"
        >
          {{ organization.name }}
        </option>
      </select-input>
      <text-input
        v-model="form.contact.email"
        :errors="form.errors.email"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Email"
      />
      <text-input
        v-model="form.contact.phone"
        :errors="form.errors.phone"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Phone"
      />
      <text-input
        v-model="form.contact.address"
        :errors="form.errors.address"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Address"
      />
      <text-input
        v-model="form.contact.city"
        :errors="form.errors.city"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="City"
      />
      <text-input
        v-model="form.contact.region"
        :errors="form.errors.region"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Province/State"
      />
      <select-input
        v-model="form.contact.country"
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
        v-model="form.contact.postal_code"
        :errors="form.errors.postal_code"
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
    organizations: {
      type: Array,
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
