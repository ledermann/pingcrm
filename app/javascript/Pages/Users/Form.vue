<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-8 -mr-6 -mb-8 flex flex-wrap">
      <text-input
        v-model="form.user.first_name"
        :errors="form.errors.first_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="First name"
      />
      <text-input
        v-model="form.user.last_name"
        :errors="form.errors.last_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Last name"
      />
      <text-input
        v-model="form.user.email"
        :errors="form.errors.email"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Email"
      />
      <text-input
        v-model="form.user.password"
        :errors="form.errors.password"
        class="pr-6 pb-8 w-full lg:w-1/2"
        type="password"
        autocomplete="new-password"
        label="Password"
      />
      <select-input
        v-model="form.user.owner"
        :errors="form.errors.owner"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Owner"
      >
        <option :value="true">
          Yes
        </option>
        <option :value="false">
          No
        </option>
      </select-input>
      <file-input
        v-model="form.user.photo"
        :errors="form.errors.photo"
        class="pr-6 pb-8 w-full lg:w-1/2"
        type="file"
        accept="image/*"
        label="Photo"
      />
    </div>
    <slot />
  </form>
</template>

<script>
import SelectInput from '@/Shared/SelectInput.vue'
import TextInput from '@/Shared/TextInput.vue'
import FileInput from '@/Shared/FileInput.vue'

export default {
  components: {
    SelectInput,
    TextInput,
    FileInput,
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
