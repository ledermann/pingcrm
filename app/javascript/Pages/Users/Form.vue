<template>
  <form @submit.prevent="$emit('submit')">
    <div class="-mr-6 -mb-8 flex flex-wrap p-8">
      <text-input
        v-model="form.user.first_name"
        :errors="form.errors.first_name"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="First name"
      />
      <text-input
        v-model="form.user.last_name"
        :errors="form.errors.last_name"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Last name"
      />
      <text-input
        v-model="form.user.email"
        :errors="form.errors.email"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Email"
      />
      <text-input
        v-model="form.user.password"
        :errors="form.errors.password"
        class="w-full pr-6 pb-8 lg:w-1/2"
        type="password"
        autocomplete="new-password"
        label="Password"
      />
      <select-input
        v-model="form.user.owner"
        :errors="form.errors.owner"
        class="w-full pr-6 pb-8 lg:w-1/2"
        label="Owner"
      >
        <option :value="true">Yes</option>
        <option :value="false">No</option>
      </select-input>
      <file-input
        v-model="form.user.photo"
        :errors="form.errors.photo"
        class="w-full pr-6 pb-8 lg:w-1/2"
        type="file"
        accept="image/*"
        label="Photo"
      />
    </div>
    <slot />
  </form>
</template>

<script>
import SelectInput from '@/Shared/SelectInput.vue';
import TextInput from '@/Shared/TextInput.vue';
import FileInput from '@/Shared/FileInput.vue';

export default {
  components: {
    SelectInput,
    TextInput,
    FileInput,
  },
  props: {
    modelValue: {
      type: Object,
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
