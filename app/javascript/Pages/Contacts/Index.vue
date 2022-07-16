<template>
  <div>
    <Head title="Contacts" />
    <h1 class="mb-8 text-3xl font-bold">Contacts</h1>
    <div class="mb-6 flex items-center justify-between">
      <search-filter
        v-model="form.search"
        class="mr-4 w-full max-w-md"
        @reset="reset"
      >
        <label class="block text-gray-800" for="trashed-filter">Trashed:</label>
        <select
          id="trashed-filter"
          v-model="form.trashed"
          class="form-select mt-1 w-full"
        >
          <option :value="null" />
          <option value="with">With Trashed</option>
          <option value="only">Only Trashed</option>
        </select>
      </search-filter>
      <Link class="btn-indigo" :href="$routes.new_contact()">
        Create <span class="hidden md:inline">Contact</span>
      </Link>
    </div>
    <div class="overflow-x-auto rounded bg-white shadow">
      <table class="w-full whitespace-nowrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">Name</th>
            <th class="px-6 pt-6 pb-4">Organization</th>
            <th class="px-6 pt-6 pb-4">City</th>
            <th class="px-6 pt-6 pb-4" colspan="2">Phone</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="contact in contacts.data"
            :key="contact.id"
            class="focus-within:bg-gray-100 hover:bg-gray-100"
          >
            <td class="border-t">
              <Link
                class="flex items-center px-6 py-4 focus:text-indigo-500"
                :href="$routes.edit_contact(contact.id)"
                aria-label="Edit"
              >
                {{ contact.name }}
                <icon
                  v-if="contact.deleted_at"
                  name="trash"
                  class="ml-2 h-3 w-3 flex-shrink-0 fill-gray-500"
                />
              </Link>
            </td>
            <td class="border-t">
              <Link
                class="flex items-center px-6 py-4"
                :href="$routes.edit_contact(contact.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                <div v-if="contact.organization">
                  {{ contact.organization.name }}
                </div>
              </Link>
            </td>
            <td class="border-t">
              <Link
                class="flex items-center px-6 py-4"
                :href="$routes.edit_contact(contact.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ contact.city }}
              </Link>
            </td>
            <td class="border-t">
              <Link
                class="flex items-center px-6 py-4"
                :href="$routes.edit_contact(contact.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ contact.phone }}
              </Link>
            </td>
            <td class="w-px border-t">
              <Link
                class="flex items-center px-4"
                :href="$routes.edit_contact(contact.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                <icon
                  name="cheveron-right"
                  class="block h-6 w-6 fill-gray-500"
                />
              </Link>
            </td>
          </tr>
          <tr v-if="contacts.data.length === 0">
            <td class="border-t px-6 py-4" colspan="4">No contacts found.</td>
          </tr>
        </tbody>
      </table>
    </div>
    <pagination :meta="contacts.meta" />
  </div>
</template>

<script>
import { Head, Link } from '@inertiajs/inertia-vue3';
import Icon from '@/Shared/Icon.vue';
import Layout from '@/Layouts/Main.vue';
import mapValues from 'lodash/mapValues';
import Pagination from '@/Shared/Pagination.vue';
import pickBy from 'lodash/pickBy';
import SearchFilter from '@/Shared/SearchFilter.vue';
import throttle from 'lodash/throttle';

export default {
  components: {
    Head,
    Link,
    Icon,
    Pagination,
    SearchFilter,
  },
  layout: Layout,
  props: {
    contacts: {
      type: Object,
      required: true,
    },
    filters: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        trashed: this.filters.trashed,
      },
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.get(
          this.$routes.contacts(
            Object.keys(query).length ? query : { remember: 'forget' },
          ),
          {},
          {
            preserveState: true,
            preserveScroll: true,
            replace: true,
            only: ['contacts'],
          },
        );
      }, 150),
      deep: true,
    },
  },
  methods: {
    reset() {
      this.form = mapValues(this.form, () => null);
    },
  },
};
</script>
