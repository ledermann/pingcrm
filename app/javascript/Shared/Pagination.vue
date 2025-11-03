<template>
  <div class="-mb-1 mt-6 flex flex-wrap">
    <template v-for="(link, key) in links">
      <div
        v-if="link.label === 'gap'"
        :key="key"
        class="mb-1 mr-1 px-4 py-3 text-sm text-gray-500"
      >
        …
      </div>
      <div
        v-else-if="link.url === null"
        :key="key + 'else1'"
        class="mb-1 mr-1 rounded-sm border border-gray-400 px-4 py-3 text-sm text-gray-700"
        :class="{ 'ml-auto': link.label === 'Next' }"
      >
        {{ link.label }}
      </div>
      <Link
        v-else
        :key="key + 'else2'"
        class="mb-1 mr-1 rounded-sm border border-gray-400 px-4 py-3 text-sm text-gray-900 hover:bg-white focus:border-indigo-500 focus:text-indigo-500"
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
import { Link } from '@inertiajs/vue3';

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
      const series = this.meta.series || [];
      return [
        {
          label: 'Previous',
          url: this.url(this.meta.previous),
        },
        ...series.map((page) => {
          return {
            label: page === 'gap' ? 'gap' : page,
            url: page === 'gap' ? null : this.url(page),
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
      // Handle null, undefined, or 'gap'
      if (!pageNumber || pageNumber === 'gap') {
        return null;
      }
      // Convert string to number (current page is returned as string from Pagy)
      const num = typeof pageNumber === 'string' ? parseInt(pageNumber, 10) : pageNumber;
      if (isNaN(num)) {
        return null;
      }
      // In Pagy 43.x, the page token is 'P ' (note the space!)
      return this.meta.url_template.replace('P ', num);
    },

    active(pageNumber) {
      const num = typeof pageNumber === 'string' ? parseInt(pageNumber, 10) : pageNumber;
      return this.meta.page == num;
    },
  },
};
</script>
