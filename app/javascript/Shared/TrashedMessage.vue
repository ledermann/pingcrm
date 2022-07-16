<template>
  <div
    class="flex items-center justify-between rounded border border-yellow-500 bg-yellow-300 p-4"
  >
    <div class="flex items-center">
      <icon name="trash" class="mr-2 h-4 w-4 flex-shrink-0 fill-yellow-900" />
      <div class="text-yellow-900">
        <slot />
      </div>
    </div>
    <button
      class="text-yellow-900 hover:underline"
      tabindex="-1"
      type="button"
      @click="$emit('restore')"
    >
      Restore
    </button>
  </div>
</template>

<script>
import Icon from '@/Shared/Icon.vue';

export default {
  components: {
    Icon,
  },
  emits: ['restore'],
};
</script>
