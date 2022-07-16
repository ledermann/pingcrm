<template>
  <div>
    <h1 class="mb-8 text-3xl font-bold">Users</h1>
    <div class="mb-6 flex items-center justify-between">
      <search-filter
        v-model="form.search"
        class="mr-4 w-full max-w-md"
        @reset="reset"
      >
        <label class="block text-gray-800" for="role-filter">Role:</label>
        <select
          id="role-filter"
          v-model="form.role"
          class="form-select mt-1 w-full"
        >
          <option :value="null" />
          <option value="user">User</option>
          <option value="owner">Owner</option>
        </select>
        <label class="mt-4 block text-gray-800" for="trashed-filter"
          >Trashed:</label
        >
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
      <inertia-link
        v-if="can.create_user"
        class="btn-indigo"
        :href="$routes.new_user()"
      >
        Create <span class="hidden md:inline">User</span>
      </inertia-link>
    </div>
    <div class="overflow-x-auto rounded bg-white shadow">
      <table class="w-full whitespace-nowrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">Name</th>
            <th class="px-6 pt-6 pb-4">Email</th>
            <th class="px-6 pt-6 pb-4" colspan="2">Role</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="user in users"
            :key="user.id"
            class="focus-within:bg-gray-100 hover:bg-gray-100"
          >
            <td class="border-t">
              <inertia-link
                class="flex items-center px-6 py-4 focus:text-indigo-500"
                :href="$routes.edit_user(user.id)"
                aria-label="Edit"
              >
                <img
                  v-if="user.photo"
                  class="-my-2 mr-2 block h-5 w-5 rounded-full"
                  :src="user.photo"
                  alt="Photo"
                />
                {{ user.name }}
                <icon
                  v-if="user.deleted_at"
                  name="trash"
                  class="ml-2 h-3 w-3 flex-shrink-0 fill-gray-500"
                />
              </inertia-link>
            </td>
            <td class="border-t">
              <inertia-link
                class="flex items-center px-6 py-4"
                :href="$routes.edit_user(user.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ user.email }}
              </inertia-link>
            </td>
            <td class="border-t">
              <inertia-link
                class="flex items-center px-6 py-4"
                :href="$routes.edit_user(user.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ user.owner ? 'Owner' : 'User' }}
              </inertia-link>
            </td>
            <td class="w-px border-t">
              <inertia-link
                class="flex items-center px-4"
                :href="$routes.edit_user(user.id)"
                tabindex="-1"
                aria-label="Edit"
              >
                <icon
                  name="cheveron-right"
                  class="block h-6 w-6 fill-gray-500"
                />
              </inertia-link>
            </td>
          </tr>
          <tr v-if="users.length === 0">
            <td class="border-t px-6 py-4" colspan="4">No users found.</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import Icon from '@/Shared/Icon.vue';
import Layout from '@/Layouts/Main.vue';
import mapValues from 'lodash/mapValues';
import pickBy from 'lodash/pickBy';
import SearchFilter from '@/Shared/SearchFilter.vue';
import throttle from 'lodash/throttle';

export default {
  metaInfo: { title: 'Users' },
  components: {
    Icon,
    SearchFilter,
  },
  layout: Layout,
  props: {
    users: {
      type: Array,
      required: true,
    },
    filters: {
      type: Object,
      required: true,
    },
    can: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        role: this.filters.role,
        trashed: this.filters.trashed,
      },
    };
  },
  watch: {
    form: {
      handler: throttle(function () {
        let query = pickBy(this.form);
        this.$inertia.get(
          this.$routes.users(
            Object.keys(query).length ? query : { remember: 'forget' },
          ),
          {},
          {
            preserveState: true,
            preserveScroll: true,
            replace: true,
            only: ['users'],
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
