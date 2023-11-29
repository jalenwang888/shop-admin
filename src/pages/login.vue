<script setup>
  import store from '@/store';
  import { VForm } from 'vuetify/components/VForm'
  import { useAppAbility } from '@/plugins/casl/useAppAbility'
  import AuthProvider from '@/views/pages/authentication/AuthProvider.vue'
  import authV1BottomShape from '@images/svg/auth-v1-bottom-shape.svg?raw'
  import authV1TopShape from '@images/svg/auth-v1-top-shape.svg?raw'
  
  import axios from '@axios'
  import { useGenerateImageVariant } from '@core/composable/useGenerateImageVariant'
  import authV2LoginIllustrationBorderedDark from '@images/pages/auth-v2-login-illustration-bordered-dark.png'
  import authV2LoginIllustrationBorderedLight from '@images/pages/auth-v2-login-illustration-bordered-light.png'
  import authV2LoginIllustrationDark from '@images/pages/auth-v2-login-illustration-dark.png'
  import authV2LoginIllustrationLight from '@images/pages/auth-v2-login-illustration-light.png'
  import authV2MaskDark from '@images/pages/misc-mask-dark.png'
  import authV2MaskLight from '@images/pages/misc-mask-light.png'
  import { VNodeRenderer } from '@layouts/components/VNodeRenderer'
  import { themeConfig } from '@themeConfig'
  import {
    emailValidator,
    requiredValidator,
  } from '@validators'

  import {useImStore} from '@/views/im/useImStore'
  const imStore = useImStore()
  
  const authThemeImg = useGenerateImageVariant(authV2LoginIllustrationLight, authV2LoginIllustrationDark, authV2LoginIllustrationBorderedLight, authV2LoginIllustrationBorderedDark, true)
  const authThemeMask = useGenerateImageVariant(authV2MaskLight, authV2MaskDark)
  const isPasswordVisible = ref(false)
  const route = useRoute()
  const router = useRouter()
  const ability = useAppAbility()
  
  const errors = ref({
    email: undefined,
    password: undefined,
  })
  
  const refVForm = ref()
  const email = ref('admin@g.com')
  const password = ref('123456')
  const rememberMe = ref(false)
  
  const login = () => {
    axios.post('imlogin', {
      email: email.value,
      password: password.value,
    }).then(r => {
      const { accessToken, userData, userAbilities } = r.data
  
      console.log('datarData', JSON.stringify(r.data))

      localStorage.setItem('userAbilities', JSON.stringify(userAbilities))
      ability.update(userAbilities)
      localStorage.setItem('userData', JSON.stringify(userData))

      console.log("LOGIN：" + JSON.stringify(userData) + " token "+accessToken)


      store.dispatch('refreshToken', accessToken)

      localStorage.setItem('accessToken', accessToken)

      imLogin()
  
      // Redirect to `to` query if exist or redirect to index route
      router.replace(route.query.to ? String(route.query.to) : '/')
    }).catch(e => {
      const { errors: formErrors } = e.response.data
  
      
      errors.value = formErrors
      console.error(e.response.data)
    })
  }
  
  const onSubmit = () => {
    refVForm.value?.validate().then(({ valid: isValid }) => {
      if (isValid)
        login()
        
    })
  }

  const imLogin = () => {
      imStore.imLogin().then(response => {
        let userDataStore = []
        let imAdmin =
        {
          'userSig': response.data.userSig,
          'userId': response.data.userId,
        }
        userDataStore = JSON.parse(localStorage.getItem('userData'));
  
        userDataStore.imAdmin = imAdmin
        localStorage.setItem('userData', JSON.stringify(userDataStore));
  
        imStore.login(imAdmin).then().catch(error => {
          console.error(error.response)
          return toast.error("IM登录系统错误，请联系管理员！[400009]")
        })
      }).catch(error => {
        console.error(error.response)
        return toast.error("IM获取信息错误，请联系管理员！[400010]")
      })
    }
  </script>
  
  <template>
    <div class="auth-wrapper d-flex align-center justify-center pa-4">
      <div class="position-relative my-sm-16">
        <!-- 👉 Top shape -->
        <VNodeRenderer
          :nodes="h('div', { innerHTML: authV1TopShape })"
          class="text-primary auth-v1-top-shape d-none d-sm-block"
        />
  
        <!-- 👉 Bottom shape -->
        <VNodeRenderer
          :nodes="h('div', { innerHTML: authV1BottomShape })"
          class="text-primary auth-v1-bottom-shape d-none d-sm-block"
        />
  
        <!-- 👉 Auth Card -->
        <VCard
          class="auth-card pa-4"
          max-width="448"
        >
          <VCardItem class="justify-center">
            <template #prepend>
              <div class="d-flex">
                <VNodeRenderer :nodes="themeConfig.app.logo" />
              </div>
            </template>
  
            <VCardTitle class="font-weight-bold text-capitalize text-h5 py-1">
              {{ themeConfig.app.title }}
            </VCardTitle>
          </VCardItem>
  
        
  
          <VCardText>
  
            <VForm
              ref="refVForm"
              @submit.prevent="onSubmit"
            >
              <VRow>
                <!-- email -->
                <VCol cols="12">
                  <AppTextField
                    v-model="email"
                    label="Email"
                    type="email"
                    autofocus
                    :rules="[requiredValidator, emailValidator]"
                    :error-messages="errors.email"
                  />
                </VCol>
  
                <!-- password -->
                <VCol cols="12">
                  <AppTextField
                    v-model="password"
                    label="Password"
                    :rules="[requiredValidator]"
                    :type="isPasswordVisible ? 'text' : 'password'"
                    :error-messages="errors.password"
                    :append-inner-icon="isPasswordVisible ? 'tabler-eye-off' : 'tabler-eye'"
                    @click:append-inner="isPasswordVisible = !isPasswordVisible"
                  />
  
                  <div class="d-flex align-center flex-wrap justify-space-between mt-2 mb-4">
                    <VCheckbox
                      v-model="rememberMe"
                      label="Remember me"
                    />
                    <RouterLink
                      class="text-primary ms-2 mb-1"
                      :to="{ name: 'forgot-password' }"
                    >
                      Forgot Password?
                    </RouterLink>
                  </div>
  
                  <VBtn
                    block
                    type="submit"
                  >
                    Login
                  </VBtn>
                </VCol>
  
                <!-- auth providers -->
           
              </VRow>
            </VForm>
  
          </VCardText>
        </VCard>
      </div>
    </div>
  </template>
  
  
  <style lang="scss">
  @use "@core/scss/template/pages/page-auth.scss";
  </style>
  
  <route lang="yaml">
  meta:
    layout: blank
    action: read
    subject: Auth
    redirectIfLoggedIn: true
  </route>
  