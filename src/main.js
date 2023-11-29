/* eslint-disable import/order */
import '@/@fake-db/db'
import '@/@iconify/icons-bundle'
import App from '@/App.vue'
import ability from '@/plugins/casl/ability'
import i18n from '@/plugins/i18n'
import layoutsPlugin from '@/plugins/layouts'
import vuetify from '@/plugins/vuetify'
import { loadFonts } from '@/plugins/webfontloader'
import router from '@/router'
import { abilitiesPlugin } from '@casl/vue'
import '@core/scss/template/index.scss'
import '@styles/styles.scss'
import { createPinia } from 'pinia'
import { createApp } from 'vue'


import Toast, { useToast } from "vue-toastification"
// Import the CSS or use your own!
import "vue-toastification/dist/index.css"

import io from "socket.io-client"

window.io = io



const toast = useToast()
window.toast = toast

loadFonts()

// Create vue app
const app = createApp(App)


// Use plugins
app.use(vuetify)
app.use(createPinia())
app.use(router)
app.use(layoutsPlugin)
app.use(i18n)
app.use(abilitiesPlugin, ability, {
  useGlobalProperties: true,
})

app.use(Toast, {
  transition: "Vue-Toastification__bounce",
  maxToasts: 8,
  icon: true,
  newestOnTop: true,
  timeout:3000,
  position: "bottom-right"
});


// Mount vue app
app.mount('#app')
