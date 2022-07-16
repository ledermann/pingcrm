<template>
  <div>
    <Head :title="`${form.organization.name}`" />
    <h1 class="mb-8 text-3xl font-bold">
      <Link
        class="text-indigo-500 hover:text-indigo-800"
        :href="$routes.organizations()"
      >
        Organizations
      </Link>
      <span class="font-medium text-indigo-400">/</span>
      {{ form.organization.name }}
    </h1>
    <trashed-message
      v-if="organization.deleted_at"
      class="mb-6"
      @restore="restore"
    >
      This organization has been deleted.
    </trashed-message>
    <div class="max-w-3xl overflow-hidden rounded bg-white shadow">
      <organization-form
        v-model="form"
        @submit="form.put($routes.organization(organization.id))"
      >
        <div
          class="flex items-center border-t border-gray-200 bg-gray-100 px-8 py-4"
        >
          <button
            v-if="!organization.deleted_at"
            class="text-red-700 hover:underline"
            tabindex="-1"
            type="button"
            @click="destroy"
          >
            Delete Organization
          </button>
          <loading-button
            :loading="form.processing"
            class="btn-indigo ml-auto"
            type="submit"
          >
            Update Organization
          </loading-button>
        </div>
      </organization-form>
    </div>
    <h2 class="mt-12 text-2xl font-bold">Contacts</h2>
    <div class="mt-6 overflow-x-auto rounded bg-white shadow">
      <table class="w-full whitespace-nowrap">
        <tr class="text-left font-bold">
          <th class="px-6 pt-6 pb-4">Name</th>
          <th class="px-6 pt-6 pb-4">City</th>
          <th class="px-6 pt-6 pb-4" colspan="2">Phone</th>
        </tr>
        <tr
          v-for="contact in contacts"
          :key="contact.id"
          class="focus-within:bg-gray-100 hover:bg-gray-100"
        >
          <td class="border-t">
            <Link
              class="flex items-center px-6 py-4 focus:text-indigo-500"
              :href="$routes.edit_contact(contact.id)"
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
            >
              {{ contact.city }}
            </Link>
          </td>
          <td class="border-t">
            <Link
              class="flex items-center px-6 py-4"
              :href="$routes.edit_contact(contact.id)"
              tabindex="-1"
            >
              {{ contact.phone }}
            </Link>
          </td>
          <td class="w-px border-t">
            <Link
              class="flex items-center px-4"
              :href="$routes.edit_contact(contact.id)"
              tabindex="-1"
            >
              <icon name="cheveron-right" class="block h-6 w-6 fill-gray-500" />
            </Link>
          </td>
        </tr>
        <tr v-if="contacts.length === 0">
          <td class="border-t px-6 py-4" colspan="4">No contacts found.</td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
import { Head, Link } from '@inertiajs/inertia-vue3';
import Icon from '@/Shared/Icon.vue';
import Layout from '@/Layouts/Main.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import OrganizationForm from './Form.vue';
import TrashedMessage from '@/Shared/TrashedMessage.vue';
import omit from 'lodash/omit';

export default {
  components: {
    Head,
    Link,
    Icon,
    LoadingButton,
    OrganizationForm,
    TrashedMessage,
  },
  layout: Layout,
  props: {
    organization: {
      type: Object,
      required: true,
    },
    contacts: {
      type: Array,
      required: true,
    },
  },
  remember: 'form',
  data() {
    return {
      form: this.$inertia.form({
        organization: omit(this.organization, 'id', 'deleted_at'),
      }),
    };
  },
  methods: {
    destroy() {
      if (confirm('Are you sure you want to delete this organization?')) {
        this.$inertia.delete(this.$routes.organization(this.organization.id));
      }
    },
    restore() {
      if (confirm('Are you sure you want to restore this organization?')) {
        this.$inertia.put(
          this.$routes.restore_organization(this.organization.id),
        );
      }
    },
  },
};
</script>
