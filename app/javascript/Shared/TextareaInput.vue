<template>
  <div :class="$attrs.class">
    <label v-if="label" class="form-label" :for="id">{{ label }}:</label>
    <textarea
      :id="id"
      ref="input"
      v-bind="{ ...$attrs, class: null }"
      class="form-textarea"
      :class="{ error: errors.length }"
      :value="modelValue"
      @input="$emit('update:modelValue', $event.target.value)"
    />
    <div v-if="errors.length" class="form-error">
      {{ errors[0] }}
    </div>
  </div>
</template>

<script>
import { v4 as uuid } from 'uuid';
export default {
  inheritAttrs: false,
  props: {
    id: {
      type: String,
      default() {
        return `textarea-input-${uuid()}`;
      },
    },
    modelValue: String,
    label: {
      type: String,
      default: null,
    },
    errors: {
      type: Array,
      default: () => [],
    },
  },
  emits: ['update:modelValue'],
  methods: {
    focus() {
      this.$refs.input.focus();
    },
    select() {
      this.$refs.input.select();
    },
  },
};
</script>
