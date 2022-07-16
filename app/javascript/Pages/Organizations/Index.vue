<template>
  <div>
    <Head title="Organizations" />
    <h1 class="mb-8 text-3xl font-bold">Organizations</h1>
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

      <button class="btn-indigo" @click="modalNew = true">
        Create <span class="hidden md:inline">Organization</span>
      </button>
      <modal
        :open="modalNew"
        title="Create Organization"
        @close="modalNew = false"
      >
        <new-organization @success="modalNew = false" />
      </modal>
    </div>
    <div class="overflow-x-auto rounded bg-white shadow">
      <table class="w-full whitespace-nowrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">Name</th>
            <th class="px-6 pt-6 pb-4">City</th>
            <th class="px-6 pt-6 pb-4" colspan="2">Phone</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="organization in organizations.data"
            :key="organization.id"
            class="focus-within:bg-gray-100 hover:bg-gray-100"
          >
            <td class="border-t">
              <Link
                class="flex items-center px-6 py-4 focus:text-indigo-500"
                :href="$routes.edit_organization(organization.id)"
              >
                {{ organization.name }}
                <icon
                  v-if="organization.deleted_at"
                  name="trash"
                  class="ml-2 h-3 w-3 flex-shrink-0 fill-gray-500"
                />
              </Link>
            </td>
            <td class="border-t">
              <Link
                class="flex items-center px-6 py-4"
                :href="$routes.edit_organization(organization.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ organization.city }}
              </Link>
            </td>
            <td class="border-t">
              <Link
                class="flex items-center px-6 py-4"
                :href="$routes.edit_organization(organization.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ organization.phone }}
              </Link>
            </td>
            <td class="w-px border-t">
              <Link
                class="flex items-center px-4"
                :href="$routes.edit_organization(organization.id)"
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
          <tr v-if="organizations.data.length === 0">
            <td class="border-t px-6 py-4" colspan="4">
              No organizations found.
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <pagination :meta="organizations.meta" />
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
import Modal from '@/Shared/Modal.vue';
import NewOrganization from '@/Pages/Organizations/_New.vue';
import throttle from 'lodash/throttle';

export default {
  components: {
    Head,
    Link,
    Icon,
    Pagination,
    SearchFilter,
    Modal,
    NewOrganization,
  },
  layout: Layout,
  props: {
    organizations: {
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
      modalNew: false,
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.get(
          this.$routes.organizations(
            Object.keys(query).length ? query : { remember: 'forget' },
          ),
          {},
          {
            preserveState: true,
            preserveScroll: true,
            replace: true,
            only: ['organizations'],
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
