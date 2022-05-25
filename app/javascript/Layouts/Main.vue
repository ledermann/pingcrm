<template>
  <minimal-layout>
    <div class="md:flex md:flex-col">
      <div
        class="md:h-screen md:flex md:flex-col"
      >
        <div class="md:flex md:flex-shrink-0">
          <div class="bg-indigo-900 md:flex-shrink-0 md:w-56 px-6 py-4 flex items-center justify-between md:justify-center">
            <inertia-link
              class="mt-1"
              :href="$routes.root()"
              aria-label="Home"
              role="navigation"
            >
              <logo
                class="fill-white"
                width="120"
                height="28"
              />
            </inertia-link>
            <dropdown
              class="md:hidden"
              placement="bottom-end"
              aria-label="Main menu"
            >
              <svg
                class="fill-white w-6 h-6"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
              ><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z" /></svg>
              <div
                slot="dropdown"
                class="mt-2 px-8 py-4 shadow-lg bg-indigo-800 rounded"
              >
                <main-menu />
              </div>
            </dropdown>
          </div>
          <div class="bg-white border-b w-full p-4 md:py-0 md:px-12 text-sm md:text-md flex justify-between items-center">
            <div class="mt-1 mr-4">
              {{ $page.props.auth.user.account.name }}
            </div>
            <dropdown
              class="mt-1"
              placement="bottom-end"
              aria-label="User menu"
            >
              <div class="flex items-center cursor-pointer select-none group">
                <div class="text-gray-800 group-hover:text-indigo-600 focus:text-indigo-600 mr-1 whitespace-nowrap">
                  {{ $page.props.auth.user.first_name }} <span class="hidden md:inline">{{ $page.props.auth.user.last_name }}</span>
                </div>
                <icon
                  class="w-5 h-5 group-hover:fill-indigo-600 fill-gray-800 focus:fill-indigo-600"
                  name="cheveron-down"
                />
              </div>
              <div
                slot="dropdown"
                class="mt-2 py-2 shadow-xl bg-white rounded text-sm"
              >
                <inertia-link
                  class="block px-6 py-2 hover:bg-indigo-600 hover:text-white"
                  role="navigation"
                  :href="$routes.edit_user($page.props.auth.user.id)"
                >
                  My Profile
                </inertia-link>
                <inertia-link
                  class="block px-6 py-2 hover:bg-indigo-600 hover:text-white"
                  role="navigation"
                  :href="$routes.users()"
                >
                  Manage Users
                </inertia-link>
                <inertia-link
                  class="block w-full text-left px-6 py-2 hover:bg-indigo-600 hover:text-white"
                  :href="$routes.destroy_user_session()"
                  method="delete"
                  as="button"
                >
                  Logout
                </inertia-link>
              </div>
            </dropdown>
          </div>
        </div>
        <div class="md:flex md:flex-grow md:overflow-hidden">
          <main-menu class="hidden md:block bg-indigo-800 flex-shrink-0 w-56 p-12 overflow-y-auto" />
          <div
            class="md:flex-1 px-4 py-8 md:p-12 md:overflow-y-auto"
            scroll-region
          >
            <flash-messages />
            <slot />
          </div>
        </div>
      </div>
    </div>
  </minimal-layout>
</template>

<script>
import MinimalLayout from '@/Layouts/Minimal.vue'
import Dropdown from '@/Shared/Dropdown.vue'
import FlashMessages from '@/Shared/FlashMessages.vue'
import Icon from '@/Shared/Icon.vue'
import Logo from '@/Shared/Logo.vue'
import MainMenu from '@/Shared/MainMenu.vue'

export default {
  components: {
    MinimalLayout,
    Dropdown,
    FlashMessages,
    Icon,
    Logo,
    MainMenu,
  },
}
</script>
