<template>
  <div>
    <label v-if="label" class="form-label">{{ label }}:</label>
    <div class="form-input p-0" :class="{ error: errors.length }">
      <input
        ref="file"
        type="file"
        :accept="accept"
        class="hidden"
        @change="change"
      />
      <div v-if="!modelValue" class="p-2">
        <button
          type="button"
          class="rounded-sm bg-gray-700 px-4 py-1 text-xs font-medium text-white hover:bg-gray-700"
          @click="browse"
        >
          Browse
        </button>
      </div>
      <div v-else class="flex items-center justify-between p-2">
        <div class="flex-1 pr-1">
          {{ modelValue.name }}
          <span class="text-xs text-gray-600"
            >({{ filesize(modelValue.size) }})</span
          >
        </div>
        <button
          type="button"
          class="rounded-sm bg-gray-700 px-4 py-1 text-xs font-medium text-white hover:bg-gray-700"
          @click="remove"
        >
          Remove
        </button>
      </div>
    </div>
    <div v-if="errors.length" class="form-error">
      {{ errors[0] }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    modelValue: File,
    label: {
      type: String,
      default: null,
    },
    accept: {
      type: String,
      default: null,
    },
    errors: {
      type: Array,
      default: () => [],
    },
  },
  emits: ['update:modelValue'],
  watch: {
    modelValue(value) {
      if (!value) {
        this.$refs.file.value = '';
      }
    },
  },
  methods: {
    filesize(size) {
      var i = Math.floor(Math.log(size) / Math.log(1024));
      return (
        (size / Math.pow(1024, i)).toFixed(2) * 1 +
        ' ' +
        ['B', 'kB', 'MB', 'GB', 'TB'][i]
      );
    },
    browse() {
      this.$refs.file.click();
    },
    change(e) {
      this.$emit('update:modelValue', e.target.files[0]);
    },
    remove() {
      this.$emit('update:modelValue', null);
    },
  },
};
</script>
