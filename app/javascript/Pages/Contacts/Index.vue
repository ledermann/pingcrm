<template>
  <div>
    <h1 class="mb-8 font-bold text-3xl">Contacts</h1>
    <div class="mb-6 flex justify-between items-center">
      <search-filter v-model="form.search" class="w-full max-w-md mr-4" @reset="reset">
        <label class="block text-gray-800">Trashed:</label>
        <select v-model="form.trashed" class="mt-1 w-full form-select">
          <option :value="null" />
          <option value="with">With Trashed</option>
          <option value="only">Only Trashed</option>
        </select>
      </search-filter>
      <inertia-link class="btn-indigo" :href="$routes.new_contact()">
        <span>Create</span>
        <span class="hidden md:inline">Contact</span>
      </inertia-link>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto">
      <table class="w-full whitespace-no-wrap">
        <tr class="text-left font-bold">
          <th class="px-6 pt-6 pb-4">Name</th>
          <th class="px-6 pt-6 pb-4">Organization</th>
          <th class="px-6 pt-6 pb-4">City</th>
          <th class="px-6 pt-6 pb-4" colspan="2">Phone</th>
        </tr>
        <tr v-for="contact in contacts.data" :key="contact.id" class="hover:bg-gray-100 focus-within:bg-gray-100">
          <td class="border-t">
            <inertia-link class="px-6 py-4 flex items-center focus:text-indigo" :href="$routes.edit_contact(contact.id)">
              {{ contact.name }}
              <icon v-if="contact.deleted_at" name="trash" class="flex-shrink-0 w-3 h-3 fill-gray-500 ml-2" />
            </inertia-link>
          </td>
          <td class="border-t">
            <inertia-link class="px-6 py-4 flex items-center" :href="$routes.edit_contact(contact.id)" tabindex="-1">
              <div v-if="contact.organization">
                {{ contact.organization.name }}
              </div>
            </inertia-link>
          </td>
          <td class="border-t">
            <inertia-link class="px-6 py-4 flex items-center" :href="$routes.edit_contact(contact.id)" tabindex="-1">
              {{ contact.city }}
            </inertia-link>
          </td>
          <td class="border-t">
            <inertia-link class="px-6 py-4 flex items-center" :href="$routes.edit_contact(contact.id)" tabindex="-1">
              {{ contact.phone }}
            </inertia-link>
          </td>
          <td class="border-t w-px">
            <inertia-link class="px-4 flex items-center" :href="$routes.edit_contact(contact.id)" tabindex="-1">
              <icon name="cheveron-right" class="block w-6 h-6 fill-gray-500" />
            </inertia-link>
          </td>
        </tr>
        <tr v-if="contacts.data.length === 0">
          <td class="border-t px-6 py-4" colspan="4">No contacts found.</td>
        </tr>
      </table>
    </div>
    <pagination :meta="contacts.meta" />
  </div>
</template>

<script>
import _ from 'lodash'
import Icon from '@/Shared/Icon'
import Layout from '@/Shared/Layout'
import Pagination from '@/Shared/Pagination'
import SearchFilter from '@/Shared/SearchFilter'

export default {
  metaInfo: { title: 'Contacts' },
  layout: (h, page) => h(Layout, [page]),
  components: {
    Icon,
    Pagination,
    SearchFilter
  },
  props: {
    contacts: Object,
    filters: Object
  },
  data() {
    return {
      form: {
        search: this.filters.search,
        trashed: this.filters.trashed
      }
    }
  },
  watch: {
    form: {
      handler: _.throttle(function() {
        let query = _.pickBy(this.form)
        this.$inertia.replace(
          this.$routes.contacts(
            Object.keys(query).length ? query : { remember: 'forget' }
          )
        )
      }, 150),
      deep: true
    }
  },
  methods: {
    reset() {
      this.form = _.mapValues(this.form, () => null)
    }
  }
}
</script>
