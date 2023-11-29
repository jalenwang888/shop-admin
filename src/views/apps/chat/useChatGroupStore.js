import axios from "@axios";
import { defineStore } from "pinia";

export const useChatGroupStore = defineStore("ChatGroupStore", {
  actions: {
    // 👉 Fetch all Reports
    async fetchChatGroup(limit, page, status = null) {
      const data = {
        "Limit": limit,
        "Next": 0,
        "GroupType": "Public",
        "Website": "All"
      }
      if (status)
        data.status = status

        return new Promise((resolve, reject) => {
          axios.post('group/list?page='+page, data).then(response => resolve(response)).catch(error => reject(error))
      })
      
    },

  },
});
