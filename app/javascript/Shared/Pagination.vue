<template>
  <div class="mt-6 -mb-1 flex flex-wrap">
    <template v-for="(link, key) in links">
      <div
        v-if="link.label === 'gap'"
        :key="key"
        class="mr-1 mb-1 px-4 py-3 text-sm text-gray-500"
      >
        …
      </div>
      <div
        v-else-if="link.url === null"
        :key="key + 'else1'"
        class="mr-1 mb-1 rounded border border-gray-400 px-4 py-3 text-sm text-gray-700"
        :class="{ 'ml-auto': link.label === 'Next' }"
      >
        {{ link.label }}
      </div>
      <Link
        v-else
        :key="key + 'else2'"
        class="mr-1 mb-1 rounded border border-gray-400 px-4 py-3 text-sm text-gray-900 hover:bg-white focus:border-indigo-500 focus:text-indigo-500"
        :class="{ 'bg-white': link.active, 'ml-auto': link.label === 'Next' }"
        :href="link.url"
        preserve-state
        preserve-scroll
      >
        {{ link.label }}
      </Link>
    </template>
  </div>
</template>

<script>
import { Link } from '@inertiajs/inertia-vue3';

export default {
  components: {
    Link,
  },
  props: {
    meta: {
      type: Object,
      required: true,
    },
  },

  computed: {
    links() {
      return [
        {
          label: 'Previous',
          url: this.url(this.meta.prev),
        },
        ...this.meta.sequels['0'].map((page) => {
          return {
            label: page,
            url: this.url(page),
            active: this.active(page),
          };
        }),
        {
          label: 'Next',
          url: this.url(this.meta.next),
        },
      ];
    },
  },

  methods: {
    url(pageNumber) {
      return pageNumber
        ? this.meta.scaffold_url.replace(/__pagy_page__/, pageNumber)
        : null;
    },
    active(pageNumber) {
      return this.meta.page == pageNumber;
    },
  },
};
</script>
