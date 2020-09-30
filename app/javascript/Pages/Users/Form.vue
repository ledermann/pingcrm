<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-8 -mr-6 -mb-8 flex flex-wrap">
      <text-input
        v-model="form.first_name"
        :errors="$page.errors.first_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="First name"
      />
      <text-input
        v-model="form.last_name"
        :errors="$page.errors.last_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Last name"
      />
      <text-input
        v-model="form.email"
        :errors="$page.errors.email"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Email"
      />
      <text-input
        v-model="form.password"
        :errors="$page.errors.password"
        class="pr-6 pb-8 w-full lg:w-1/2"
        type="password"
        autocomplete="new-password"
        label="Password"
      />
      <select-input
        v-model="form.owner"
        :errors="$page.errors.owner"
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
        v-model="form.photo"
        :errors="$page.errors.photo"
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
import SelectInput from '@/Shared/SelectInput'
import TextInput from '@/Shared/TextInput'
import FileInput from '@/Shared/FileInput'

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
