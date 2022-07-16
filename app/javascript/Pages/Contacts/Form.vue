<template>
  <form @submit.prevent="$emit('submit')">
    <div class="-mr-6 -mb-8 flex flex-wrap p-8">
      <text-input
        v-model="form.contact.first_name"
        :errors="form.errors.first_name"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="First name"
      />
      <text-input
        v-model="form.contact.last_name"
        :errors="form.errors.last_name"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Last name"
      />
      <select-input
        v-model="form.contact.organization_id"
        :errors="form.errors.organization_id"
        class="w-full pr-6 pb-8 lg:w-1/2"
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
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Email"
      />
      <text-input
        v-model="form.contact.phone"
        :errors="form.errors.phone"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Phone"
      />
      <text-input
        v-model="form.contact.address"
        :errors="form.errors.address"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Address"
      />
      <text-input
        v-model="form.contact.city"
        :errors="form.errors.city"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="City"
      />
      <text-input
        v-model="form.contact.region"
        :errors="form.errors.region"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Province/State"
      />
      <select-input
        v-model="form.contact.country"
        :errors="form.errors.country"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Country"
      >
        <option :value="null" />
        <option value="CA">Canada</option>
        <option value="US">United States</option>
      </select-input>
      <text-input
        v-model="form.contact.postal_code"
        :errors="form.errors.postal_code"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Postal code"
      />
    </div>

    <slot />
  </form>
</template>

<script>
import SelectInput from '@/Shared/SelectInput.vue';
import TextInput from '@/Shared/TextInput.vue';

export default {
  components: {
    SelectInput,
    TextInput,
  },
  props: {
    modelValue: {
      type: Object,
      required: true,
    },
    organizations: {
      type: Array,
      required: true,
    },
  },
  emits: ['update:modelValue', 'submit'],
  computed: {
    form: {
      get() {
        return this.modelValue;
      },
      set(val) {
        this.$emit('update:modelValue', val);
      },
    },
  },
};
</script>
