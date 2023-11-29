import axios from 'axios'
import vuex from 'vuex'

export default new vuex.Store({
    state: {
        userId: null,
        faceUrl: null,
        nick: null,
        accessToken: null,
        auth: false,
    },
    mutations: {
        // 用户登录成功，存储 token 并设置 header 头
        logined(state, accessToken) {
            state.auth = true
            state.accessToken = accessToken
            localStorage.accessToken = accessToken

            //LaravelEcho.setToken = accessToken
        },
        // 用户刷新 accessToken 成功，使用新的 accessToken 替换掉本地的accessToken
        refreshToken(state, accessToken) {
            state.accessToken = accessToken
            localStorage.accessToken = accessToken
            axios.defaults.headers.common['Authorization'] = accessToken

            console.log("更新 TOKEN： "+accessToken);
        },
        // 登录成功后拉取用户的信息存储到本地
        profile(state, data) {
            state.userId = data.userId
            state.nick = data.nick
            state.faceUrl = data.faceUrl
            localStorage.userData  = JSON.stringify(data)
        },
        // 用户登出，清除本地数据
        logout(state){
            state.userId = null
            state.nick = null
            state.faceUrl = null
            state.auth = false
            state.accessToken = null
 
            localStorage.removeItem('accessToken')
        }
    },
    actions: {
         // 登录成功后保存用户信息
        logined({dispatch,commit}, data) {
            return new Promise(function (resolve, reject) {
                commit('logined', data.accessToken)
                axios.defaults.headers.common['Authorization'] = data.accessToken
                //LaravelEcho.setToken = state.accessToken
                commit('profile', data.userData)
            })
        },
        // 登录成功后使用 accessToken 拉取用户的信息
        /**
        profile({commit}) {
            return new Promise(function (resolve, reject) {
                axios.get('profile', {}).then(respond => {
                    if (respond.status == 200) {
                        commit('profile', respond.data)
                        resolve()
                    } else {
                        reject()
                    }
                })
            })
        },
         */
        // 用户登出，清除本地数据并重定向至登录页面
        logout({commit}) {
            return new Promise(function (resolve, reject) {
                commit('logout')
                axios.post('logout', {}).then(respond => {
                    Vue.$router.push({userId:'login'})
                })
            })
        },
        // 将刷新的 accessToken 保存至本地
        refreshToken({commit},accessToken) {
            return new Promise(function (resolve, reject) {
                commit('refreshToken', accessToken)
            })
        },
    }
 })
 
