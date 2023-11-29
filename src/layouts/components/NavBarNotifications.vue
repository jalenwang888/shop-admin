<script setup>
  //import LaravelEcho from '@/helpers/laravel-echo'
  import LaravelEcho from '@/helpers/laravel-echo-socket'

  import avatar3 from '@images/avatars/avatar-3.png'
  import avatar4 from '@images/avatars/avatar-4.png'
  import avatar5 from '@images/avatars/avatar-5.png'
  import paypal from '@images/svg/paypal.svg'

  import {useNotificationStore} from '@/views/notifications/useNotificationStore'



  const notificationStore = useNotificationStore()


  const router = useRouter()

  const notifications = ref([])

  let userData = JSON.parse(localStorage.getItem("userData"))

  const useWebsocket = () => {
    LaravelEcho.instance.channel('news_test').listen('SocketEvent', (e) => {
      console.log(e)
    })

    LaravelEcho.instance.private(`server.im.notify.${userData.id}`)
      .listen(".server.im", (e) => {
        toast.info(e.data.subtitle + e.data.time, {
          timeout: false,
        });

        let content = {
          id: e.data.id,
          text: e.data.text,
          title: e.data.title,
          subtitle: e.data.subtitle,
          time: e.data.time,
          isSeen: false,
        }

        content.typeLink = "/reports/view/" + e.data.text
        content.link = "/reports/view/" + e.data.id

        notifications.value.push(content)
      }).error((error) => {
        //this.$forceUpdate();
        //location.reload();
        console.error("PUSHER HERE ERROE" + JSON.stringify(error));
        //return router.push('/logout')
      });
  }

  /** 
  const useWebsocket = () => {
  
    LaravelEcho.instance.private(`server.im.notify.${userData.id}`)
      //Echo.private(`server.im.notify.${userData.id}`)
      .listen("ImEvent", (e) => {

        toast.info(e.data.subtitle + e.data.time, {
          timeout: false,
        });

        let content = {
          id: e.data.id,
          text: e.data.text,
          title: e.data.title,
          subtitle: e.data.subtitle,
          time: e.data.time,
          isSeen: false,
        }

        content.typeLink = "/reports/view/" + e.data.text
        content.link = "/reports/view/" + e.data.id

        notifications.value.push(content)
      }).error((error) => {
        //this.$forceUpdate();
        //location.reload();
        console.error("PUSHER HERE ERROE" + JSON.stringify(error));
        //return router.push('/logout')
      });
  }

  */

  onMounted(() => {
    notificationStore.notifications().then(response => {

      //console.log("NOTIFItion: " + Object.keys(response.data.data).length + " "+ JSON.stringify(response.data.data) )
      if (Object.keys(response.data.data).length > 0) {
        notifications.value = response.data.data
        notifications.value.forEach((item) => {
          item.link = "/reports/view/" + item.id
          item.typeLink = "/reports/view/" + item.text
        })
      }
    }).catch(error => {
      console.error("error" + JSON.stringify(error));

    })

    useWebsocket()
    //LaravelEcho.setToken(localStorage.getItem("accessToken"))

  })

  const removeNotification = notificationId => {
    notifications.value.forEach((item, index) => {
      if (notificationId === item.id)
        notifications.value.splice(index, 1)
    })
  }

  const markRead = notificationId => {
    notifications.value.forEach(item => {
      notificationId.forEach(id => {
        if (id === item.id) {
          item.isSeen = true
          notificationStore.read(id, 'read').then().catch(error => {
            toast.error(JSON.stringify(error.response.data));
          })
        }
      })
    })
  }

  const markUnRead = notificationId => {
    notifications.value.forEach(item => {
      notificationId.forEach(id => {
        if (id === item.id) {
          item.isSeen = true
          notificationStore.read(id, 'unread').then().catch(error => {
            toast.error(JSON.stringify(error.response.data));
          })
        }

      })
    })
  }

  const handleNotificationClick = notification => {
    if (!notification.isSeen)
      markRead([notification.id])
  }


  onUnmounted(() => {
    LaravelEcho.leave(`server.im.notify.${userData.id}`)
  })

</script>

<template>
  <Notifications :notifications="notifications" @remove="removeNotification" @read="markRead" @unread="markUnRead"
    @click:notification="handleNotificationClick" />
</template>
