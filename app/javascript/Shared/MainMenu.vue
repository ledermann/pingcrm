<template>
  <nav>
    <div class="mb-4">
      <Link
        class="group flex items-center py-3"
        :href="$routes.root()"
        aria-label="Dashboard"
      >
        <icon
          name="dashboard"
          class="mr-2 h-4 w-4"
          :class="
            isUrl('') ? 'fill-white' : 'fill-indigo-400 group-hover:fill-white'
          "
        />
        <div
          :class="
            isUrl('') ? 'text-white' : 'text-indigo-300 group-hover:text-white'
          "
        >
          Dashboard
        </div>
      </Link>
    </div>
    <div class="mb-4">
      <Link
        class="group flex items-center py-3"
        :href="$routes.organizations()"
        aria-label="Organizations"
      >
        <icon
          name="office"
          class="mr-2 h-4 w-4"
          :class="
            isUrl('organizations')
              ? 'fill-white'
              : 'fill-indigo-400 group-hover:fill-white'
          "
        />
        <div
          :class="
            isUrl('organizations')
              ? 'text-white'
              : 'text-indigo-300 group-hover:text-white'
          "
        >
          Organizations
        </div>
      </Link>
    </div>
    <div class="mb-4">
      <Link
        class="group flex items-center py-3"
        :href="$routes.contacts()"
        aria-label="Contacts"
      >
        <icon
          name="users"
          class="mr-2 h-4 w-4"
          :class="
            isUrl('contacts')
              ? 'fill-white'
              : 'fill-indigo-400 group-hover:fill-white'
          "
        />
        <div
          :class="
            isUrl('contacts')
              ? 'text-white'
              : 'text-indigo-300 group-hover:text-white'
          "
        >
          Contacts
        </div>
      </Link>
    </div>
    <div class="mb-4">
      <Link
        class="group flex items-center py-3"
        :href="$routes.reports()"
        aria-label="Reports"
      >
        <icon
          name="printer"
          class="mr-2 h-4 w-4"
          :class="
            isUrl('reports')
              ? 'fill-white'
              : 'fill-indigo-400 group-hover:fill-white'
          "
        />
        <div
          :class="
            isUrl('reports')
              ? 'text-white'
              : 'text-indigo-300 group-hover:text-white'
          "
        >
          Reports
        </div>
      </Link>
    </div>
  </nav>
</template>

<script>
import { Link } from '@inertiajs/vue3';
import Icon from '@/Shared/Icon.vue';

export default {
  components: {
    Icon,
    Link,
  },
  methods: {
    isUrl(...urls) {
      let currentUrl = this.$page.url.substr(1);

      if (urls[0] === '') {
        return currentUrl === '';
      }

      return urls.filter((url) => currentUrl.startsWith(url)).length;
    },
  },
};
</script>
