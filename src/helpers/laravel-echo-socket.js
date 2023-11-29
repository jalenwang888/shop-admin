import Echo from "laravel-echo";

const token = localStorage.getItem("accessToken");
let Authorization = token ? token : "";

const ioConfig = {
  broadcaster: "socket.io",
  host: "https://" + import.meta.env.VITE_PUSHER_WSS_HOST + ":6001",

  //host: window.location.hostname + ":6001",
  auth: { headers: { Authorization: Authorization } },
  //client: io,
  logToConsole: true,
  withCredentials: true,
  client: io,
  //transports: ["websocket"],
}
class LaravelEcho {
  static instance = null;

  constructor() {
    this.instance = new Echo(ioConfig)
  }

  leave(channel) {
    this.instance.leave(channel);
  }
}

/**
 *  new VueSocketIO({
            debug: true,
            connection: 'http://localhost:3001'
      })
 */
export default new LaravelEcho();
