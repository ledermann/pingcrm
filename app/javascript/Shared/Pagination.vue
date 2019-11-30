<template>
  <div class="mt-6 -mb-1 flex flex-wrap">
    <template v-for="(link, key) in links">
      <div
        v-if="link.label === 'gap'"
        :key="key"
        class="mr-1 mb-1 px-4 py-3 text-sm text-grey"
      >
        …
      </div>
      <div
        v-else-if="link.url === null"
        :key="key"
        class="mr-1 mb-1 px-4 py-3 text-sm border rounded text-grey"
        :class="{ 'ml-auto': link.label === 'Next' }"
      >
        {{ link.label }}
      </div>
      <inertia-link v-else
        :key="key"
        class="mr-1 mb-1 px-4 py-3 text-sm border rounded hover:bg-white focus:border-indigo focus:text-indigo"
        :class="{ 'bg-white': link.active, 'ml-auto': link.label === 'Next' }"
        :href="link.url">{{ link.label }}
      </inertia-link>
    </template>
  </div>
</template>

<script>
export default {
  props: {
    meta: Object
  },

  computed: {
    links() {
      return [
        {
          label: 'Previous',
          url: this.url(this.meta.prev)
        },
        ...this.meta.sequels['0'].map(page => {
          return {
            label: page,
            url: this.url(page),
            active: this.active(page)
          }
        }),
        {
          label: 'Next',
          url: this.url(this.meta.next)
        }
      ]
    }
  },

  methods: {
    url(pageNumber) {
      return pageNumber
        ? this.meta.scaffold_url.replace(/__pagy_page__/, pageNumber)
        : null
    },
    active(pageNumber) {
      return this.meta.page == pageNumber
    }
  }
}
</script>
