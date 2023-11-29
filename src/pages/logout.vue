<script setup>
  const router = useRouter()

  const logout = () => {
    // Remove "userData" from localStorage
    localStorage.removeItem('userData')

    // Remove "accessToken" from localStorage
    localStorage.removeItem('accessToken')
    console.log("IM 退出" + JSON.stringify(response))
      // Remove "userAbilities" from localStorage
      localStorage.removeItem('userAbilities')

      // Reset ability to initial ability
      ability.update(initialAbility)

    return router.go('/login')

  }

  onMounted(() => {
    logout()
  })

</script>
<template>
  test
</template>
<route lang="yaml">
  meta:
    layout: blank
    action: read
    subject: Auth
    redirectIfLoggedIn: true
  </route>
