import axios from "@axios";
import { defineStore } from "pinia";

export const useNotificationStore = defineStore("NotificationStore", {
  actions: {
    // 👉 Fetch all Reports
    fetchNotifications(limit, page) {
     return new Promise( async (resolve, reject) => {
          axios.post('notification/list?page='+page, {"status": "pending", "limit": limit}).then(response => resolve(response)).catch(error => reject(error))
      })
      
    },

    // 👉 Fetch all Reports
    notifications() {
        return new Promise( async (resolve, reject) => {
            axios.get('notification/navbar').then(response => resolve(response)).catch(error => reject(error))
        })
        
        },

    /**
     * 
     * @param {status, id, operator } data status,
     */
    read(id, status) {
     return new Promise( async (resolve, reject) => {
          axios.post('notification/status', {"id": id, "status": status}).then(response => resolve(response)).catch(error => reject(error))
      })
    },


    // 👉 fetch single user
    fetchReport(id) {
     return new Promise( async (resolve, reject) => {
          axios.get(`reports/list/${id}`).then(response => resolve(response)).catch(error => reject(error))
      })
    },
  },
});
