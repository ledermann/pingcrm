export default function install(Vue) {
  if (install.installed) return
  install.installed = true

  Vue.matomo = new MatomoTracker()
}

class MatomoTracker {
  constructor() {
    if (!this.enabled) return

    window._paq = []
    window._paq.push(['enableLinkTracking'])
    window._paq.push(['setTrackerUrl', this.matomoUrl])
    window._paq.push(['setSiteId', this.matomoId])

    // Create a script element and insert it in the DOM
    let pa = document.createElement('script')
    pa.type = 'text/javascript'
    pa.defer = true
    pa.async = true
    pa.src = this.matomoUrl
    let firstScript = document.getElementsByTagName('script')[0]
    firstScript.parentNode.insertBefore(pa, firstScript)
  }

  trackPageView() {
    if (!this.enabled) return

    window._paq.push(['setCustomUrl', document.location])
    window._paq.push(['setDocumentTitle', document.title])
    window._paq.push(['disableCookies'])
    window._paq.push(['trackPageView'])
  }

  get matomoHost() {
    return document.getElementsByName('matomo-host')[0].getAttribute('content')
  }

  get matomoId() {
    return document.getElementsByName('matomo-id')[0].getAttribute('content')
  }

  get matomoUrl() {
    return '//' + this.matomoHost + '/js/'
  }

  get enabled() {
    return this.matomoHost && this.matomoId
  }
}
