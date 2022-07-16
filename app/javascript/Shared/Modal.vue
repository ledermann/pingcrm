<!-- Source: https://github.com/adamwathan/vue-tailwind-examples -->

<template>
  <div v-if="showModal" class="fixed inset-0">
    <transition
      enter-active-class="transition-all transition-fast ease-out-quad"
      leave-active-class="transition-all transition-medium ease-in-quad"
      enter-class="opacity-0"
      enter-to-class="opacity-100"
      leave-class="opacity-100"
      leave-to-class="opacity-0"
      appear
      @before-leave="backdropLeaving = true"
      @after-leave="backdropLeaving = false"
    >
      <div v-if="showBackdrop">
        <div class="fixed inset-0 bg-black opacity-50" />
      </div>
    </transition>

    <transition
      enter-active-class="transition-all transition-fast ease-out-quad"
      leave-active-class="transition-all transition-medium ease-in-quad"
      enter-class="opacity-0 scale-70"
      enter-to-class="opacity-100 scale-100"
      leave-class="opacity-100 scale-100"
      leave-to-class="opacity-0 scale-70"
      appear
      @before-leave="cardLeaving = true"
      @after-leave="cardLeaving = false"
    >
      <div
        v-if="showContent"
        class="relative h-full overflow-y-auto text-center"
        @click="close"
      >
        <div class="absolute inline-block h-screen w-0 align-middle" />

        <div
          class="my-6 inline-block overflow-hidden rounded text-left align-middle"
          @click.stop
        >
          <div
            class="flex items-center justify-between border-b border-gray-200 bg-gray-100 px-8 py-4"
          >
            <h1 class="text-xl font-bold">
              {{ title }}
            </h1>

            <button
              type="button"
              class="rounded p-1 hover:bg-gray-300"
              title="Close"
              @click="close"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-4 w-4"
                viewBox="0 0 20 20"
              >
                <path
                  d="M10 8.59L2.93 1.51 1.51 2.93 8.59 10l-7.08 7.07 1.42 1.42L10 11.41l7.07 7.08 1.42-1.42L11.41 10l7.08-7.07-1.42-1.42L10 8.59z"
                />
              </svg>
            </button>
          </div>

          <slot />
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
export default {
  props: {
    open: {
      type: Boolean,
      default: false,
    },
    title: {
      type: String,
      default: null,
    },
  },
  emits: ['close'],
  data() {
    return {
      showModal: false,
      showBackdrop: false,
      showContent: false,
      backdropLeaving: false,
      cardLeaving: false,
    };
  },
  computed: {
    leaving() {
      return this.backdropLeaving || this.cardLeaving;
    },
  },
  watch: {
    open: {
      handler: function (newValue) {
        if (newValue) {
          this.show();
        } else {
          this.close();
        }
      },
      immediate: true,
    },
    leaving(newValue) {
      if (newValue === false) {
        this.showModal = false;
        this.$emit('close');
      }
    },
  },
  created() {
    document.addEventListener('keydown', this.onEscape);
  },
  unmounted() {
    document.removeEventListener('keydown', this.onEscape);
  },
  methods: {
    show() {
      this.showModal = true;
      this.showBackdrop = true;
      this.showContent = true;
      document.body.style.setProperty('overflow', 'hidden');
    },
    close() {
      this.showBackdrop = false;
      this.showContent = false;
      document.body.style.removeProperty('overflow');
    },
    onEscape(e) {
      if (this.open && e.keyCode === 27) {
        this.close();
      }
    },
  },
};
</script>
