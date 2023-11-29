import Echo from 'laravel-echo'
import Pusher from "pusher-js"

/**
 * pusher配置
 */

/** */
const token = localStorage.getItem('accessToken')
let Authorization = token ? token : ''

const pusherConfig = {
    broadcaster: "pusher",
    forceTLS: document.location.protocol === 'https:' ? true : false,
    key: import.meta.env.VITE_PUSHER_APP_KEY,
    cluster: import.meta.env.VITE_PUSHER_APP_CLUSTER,
    
    wsHost:  import.meta.env.VITE_PUSHER_WS_HOST,
    wssHost: import.meta.env.VITE_PUSHER_WSS_HOST,
    wsPort: 6001,
    wssPort: 6001,
    authEndpoint: 'https://' + import.meta.env.VITE_PUSHER_WSS_HOST + '/api/broadcasting/auth',
    //bearerToken: jwt,
    auth: {
        headers: {
            'Authorization': Authorization
        }
    },
    disableStats: true
}



class LaravelEcho {
    static instance = null

    constructor() {
        console.log("pusherConfig: "+ JSON.stringify(pusherConfig))
        this.instance = new Echo({
            client: new Pusher(import.meta.env.VITE_PUSHER_APP_KEY, pusherConfig),
            broadcaster: 'pusher',
            cluster: import.meta.env.VITE_PUSHER_APP_CLUSTER
        })
    }

    setToken(token) {
      console.log( "SETTOKEN: " + JSON.stringify(this.instance.options.client.config.auth) )
      this.instance.options.client.config.auth = {
        headers: {
          Authorization: token
        },
      }
      console.log( "SETTOKEN: New" + JSON.stringify(this.instance.options.client.authEndpoint) )


      //this.instance.options.client.config.auth.headers.Authorization = token
  }

  removeToken() {
    this.instance.options.client.config.auth.headers = {}
  }

    leave(channel) {
        this.instance.leave(channel)
    }
   
}

export default new LaravelEcho()
