import Vue from 'vue'
import Notifications from 'vue-notification'
Vue.use(Notifications)

export default function showFlash({ flash, errors }) {
  if (flash.success) {
    Vue.notify({
      title: flash.success,
      type: 'success',
    })
  } else if (flash.alert) {
    Vue.notify({
      title: flash.alert,
      type: 'error',
    })
  } else if (Object.keys(errors).length === 1) {
    Vue.notify({
      title: 'There is one form error.',
      type: 'error',
    })
  } else if (Object.keys(errors).length > 1) {
    Vue.notify({
      title: `There are ${Object.keys(errors).length} form errors.`,
      type: 'error',
    })
  }
}
