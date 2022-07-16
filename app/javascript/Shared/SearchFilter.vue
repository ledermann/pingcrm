<template>
  <div class="flex items-center">
    <div class="flex w-full rounded bg-white shadow">
      <dropdown
        class="rounded-l border-r px-4 hover:bg-gray-100 focus:z-10 focus:border-white md:px-6"
        placement="bottom-start"
        aria-label="Filter"
        :auto-close="false"
      >
        <template #default>
          <div class="flex items-baseline">
            <span class="hidden text-gray-800 md:inline">Filter</span>
            <svg
              class="h-2 w-2 fill-gray-700 md:ml-2"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 961.243 599.998"
            >
              <path
                d="M239.998 239.999L0 0h961.243L721.246 240c-131.999 132-240.28 240-240.624 239.999-.345-.001-108.625-108.001-240.624-240z"
              />
            </svg>
          </div>
        </template>
        <template #dropdown>
          <div
            class="mt-2 w-screen rounded bg-white px-4 py-6 shadow-xl"
            :style="{ maxWidth: `${maxWidth}px` }"
          >
            <slot />
          </div>
        </template>
      </dropdown>
      <input
        class="w-full rounded-r px-6 py-3"
        aria-label="Search"
        autocomplete="off"
        type="text"
        name="search"
        placeholder="Search…"
        :value="modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
      />
    </div>
    <button
      class="ml-3 text-sm text-gray-700 hover:text-gray-700 focus:text-indigo-500"
      type="button"
      @click="$emit('reset')"
    >
      Reset
    </button>
  </div>
</template>

<script>
import Dropdown from '@/Shared/Dropdown.vue';

export default {
  components: {
    Dropdown,
  },
  props: {
    modelValue: String,
    maxWidth: {
      type: Number,
      default: 300,
    },
  },
  emits: ['update:modelValue', 'reset'],
};
</script>
