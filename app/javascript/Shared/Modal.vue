<!-- Source: https://github.com/adamwathan/vue-tailwind-examples -->

<template>
  <portal to="modal">
    <div
      v-if="showModal"
      class="fixed inset-0"
    >
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
          <div class="absolute inline-block align-middle w-0 h-screen" />

          <div
            class="inline-block align-middle text-left my-6"
            @click.stop
          >
            <slot />
          </div>
        </div>
      </transition>
    </div>
  </portal>
</template>

<script>
export default {
  props: {
    open: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      showModal: false,
      showBackdrop: false,
      showContent: false,
      backdropLeaving: false,
      cardLeaving: false,
    }
  },
  computed: {
    leaving() {
      return this.backdropLeaving || this.cardLeaving
    },
  },
  watch: {
    open: {
      handler: function(newValue) {
        if (newValue) {
          this.show()
        } else {
          this.close()
        }
      },
      immediate: true,
    },
    leaving(newValue) {
      if (newValue === false) {
        this.showModal = false
        this.$emit('close')
      }
    },
  },
  created() {
    const onEscape = e => {
      if (this.open && e.keyCode === 27) {
        this.close()
      }
    }
    document.addEventListener('keydown', onEscape)
    this.$once('hook:destroyed', () => {
      document.removeEventListener('keydown', onEscape)
    })
  },
  methods: {
    show() {
      this.showModal = true
      this.showBackdrop = true
      this.showContent = true
      document.body.style.setProperty('overflow', 'hidden')
    },
    close() {
      this.showBackdrop = false
      this.showContent = false
      document.body.style.removeProperty('overflow')
    },
  },
}
</script>
