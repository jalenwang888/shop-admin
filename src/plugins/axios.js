import router from '@/router';
import store from '@/store';
import axios from 'axios';
let baseURL;



// 判断开发环境（一般用于本地代理）
if (process.env.NODE_ENV === "development") {
  // 开发环境
  baseURL = "/api"; // 对应上面的代理名
} else {
  baseURL = import.meta.env.VITE_APP_BASEURL_API;
}

axios.defaults.baseURL = baseURL;
axios.defaults.crossDomain = true;
axios.defaults.headers.common["Content-Type"] = "application/json";

axios.defaults.headers.common["Access-Control-Allow-Headers"] = "Authorization, token";
axios.defaults.headers.common["Access-Control-Allow-Methods"] = "GET, POST";

axios.defaults.withCredentials = true; //是否允许带cookie这些
axios.defaults.crossDomain = true;

// ℹ️ Add response interceptor to handle 401 response
//响应拦截
axios.interceptors.response.use(
  (response) => {
    var token = response.headers.authorization;
    if (token) {
      
      //console.log("响应拦截 Token: " + token)
      store.dispatch('refreshToken', token)
    }
    return response;
  },
  (error) => {
    // Handle error
    //console.log("响应拦截 error" + JSON.stringify(error.headers.authorization));

    if (error.response.status === 401) {
      // ℹ️ Logout user and redirect to login page
      // Remove "userData" from localStorage

      localStorage.removeItem("userData");

      return router.push('/login').then(() => {

        //console.log("IM 退出" + JSON.stringify(response))
        // Remove "userAbilities" from localStorage
        localStorage.removeItem('userAbilities')
  
        // Reset ability to initial ability
        ability.update(initialAbility)
      })
  

      
    }else if(error.response.status === 429){
      toast.error(JSON.stringify(error.response.message));
      
    } else {
      return Promise.reject(error);
    }
  }
);

// ℹ️ Add request interceptor to send the authorization header on each subsequent request after login
axios.interceptors.request.use((config) => {
  // Retrieve token from localStorage
  const token = localStorage.getItem("accessToken");

  // If token is found


  if (token) {
    // Get request headers and if headers is undefined assign blank object
    config.headers = config.headers || {};

    // Set authorization header
    // ℹ️ JSON.parse will convert token to string
    config.headers.Authorization = token;

    let date = new Date() 
    //console.log(date) 
    //console.log("请求拦截 Headers" + JSON.stringify( config.headers));
  }

  // Return modified config
  return config;
});


export default axios;
