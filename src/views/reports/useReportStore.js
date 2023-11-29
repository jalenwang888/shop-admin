import axios from "@axios";
import { defineStore } from "pinia";

export const useReportStore = defineStore("ReportStore", {
  actions: {
    // 👉 Fetch all Reports
    fetchReports(limit, page, status = null) {
      const data = {
        "limit": limit
      }
      if (status)
        data.status = status

        return new Promise( async (resolve, reject) => {
          axios.post('reports/list?page='+page, data).then(response => resolve(response)).catch(error => reject(error))
      })
      
    },

    fetchReportKeywords(limit, page, status = null) {
      const data = {
        "limit": limit
      }
      if (status)
        data.status = status

        return new Promise( async (resolve, reject) => {
          axios.post('reports/keywords?page='+page, data).then(response => resolve(response)).catch(error => reject(error))
      })
    },

    updateKeywords(data) {
     return new Promise( async (resolve, reject) => {
          axios.post('reports/keywords/update', data).then(response => resolve(response)).catch(error => reject(error))
      })
    },

    editKeywords(data) {
     return new Promise( async (resolve, reject) => {
          axios.post('reports/keywords/edit', data).then(response => resolve(response)).catch(error => reject(error))
      })
    },

    addNewKeywords(data) {
     return new Promise( async (resolve, reject) => {
          axios.post('reports/keywords/add', data).then(response => resolve(response)).catch(error => reject(error))
      })
    },

    deleteKeywords(data) {
     return new Promise( async (resolve, reject) => {
          axios.post('reports/keywords/delete', data).then(response => resolve(response)).catch(error => reject(error))
      })
    },


    /**
     * 
     * @param {status, id, operator } data status,
     */
    updateReport(data) {
     return new Promise( async (resolve, reject) => {
          axios.post('reports/update', data).then(response => resolve(response)).catch(error => reject(error))
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
