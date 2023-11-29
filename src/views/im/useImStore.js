import axios from "@axios";
import { defineStore } from "pinia";
import TIM from "tim-js-sdk";

export const useImStore = defineStore("ImStore", {
  actions: {
    // 👉 Fetch all Reports
    imLogin() {
      let imData = JSON.parse(localStorage.getItem("userData"));
      console.log("IMLOGIN:" + JSON.stringify(imData));
      let userData = {
        userId: imData.username + "_" + imData.id,
        nick: "直播间管理员",
        faceUrl: import.meta.env.VITE_APP_BASEURL + "assets/img/vip_10.png",
      };
      return new Promise((resolve, reject) => {
        axios
          .post("im", userData)
          .then((response) => resolve(response))
          .catch((error) => reject(error));
      });
    },

    /**
     *
     * @param {userId, userSig} data
     */
    login(data) {
      let imData = JSON.parse(localStorage.getItem("userData"));
      let tim = TIM.create({ SDKAppID: imData.SDKID });

      return new Promise((resolve, reject) => {
        const promise = tim.login({
          userID: data.userId,
          userSig: data.userSig,
        });
        promise
          .then((response) => resolve(response))
          .catch((error) => reject(error));
      });
    },

    logout() {
      let imData = JSON.parse(localStorage.getItem("userData"));
      let tim = TIM.create({ SDKAppID: imData.SDKID });
      return new Promise((resolve, reject) => {
        let promise = tim.logout();
        promise
          .then((response) => resolve(response))
          .catch((error) => reject(error));
      });
    },

    /**
     *
     * @param {Account, Time } data
     * Time 秒
     */
    stopSpeaker(Account, Time = 60*10) {
      return new Promise((resolve, reject) => {
        axios
          .post("msg/nospeaking", { Account: Account, Time: Time })
          .then((response) => resolve(response))
          .catch((error) => reject(error));
      });
    },

    /**
     * msgData = {GroupId, Content, atUserList }
     */
    sendAtMsg(msgData) {
      let imData = JSON.parse(localStorage.getItem("userData"));
      let tim = TIM.create({ SDKAppID: imData.SDKID });

      return new Promise((resolve, reject) => {
        let message = tim.createTextAtMessage({
          to: msgData.GroupId,
          conversationType: TIM.TYPES.CONV_GROUP,
          payload: {
            text: msgData.Content,
            atUserList: msgData.atUserList, // 'denny' 'lucy' 都是 userID，而非昵称
          },
          // 消息自定义数据（云端保存，会发送到对端，程序卸载重装后还能拉取到，v2.10.2起支持）
          // cloudCustomData: 'your cloud custom data'
        });
        // 2. 发送消息
        let promise = tim.sendMessage(message, {
          messageControlInfo: {
            excludedFromContentModeration: false,
          },
        });
        promise
          .then((response) => resolve(response))
          .catch((error) => reject(error));
      });
    },

    /**
     *
     * @param {*} userData {getGroupId}
     */
    joinGroup(groupId) {
      let imData = JSON.parse(localStorage.getItem("userData"));
      let tim = TIM.create({ SDKAppID: imData.SDKID });
      return new Promise((resolve, reject) => {
        let promise = tim.joinGroup({ groupID: groupId });
        promise
          .then((response) => resolve(response))
          .catch((error) => reject(error));
      });
    },

    // 👉 fetch single user
    fetchReport(id) {
      let imData = JSON.parse(localStorage.getItem("userData"));
      let tim = TIM.create({ SDKAppID: imData.SDKID });
      return new Promise((resolve, reject) => {
        console.log(`reports/list/${id}`);
        axios
          .get(`reports/list/${id}`)
          .then((response) => resolve(response))
          .catch((error) => reject(error));
      });
    },
  },
});
