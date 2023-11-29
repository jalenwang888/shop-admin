import axios from '@axios'

export const useChatStore = defineStore('chat', {
  actions: {
    async fetchChatsAndContacts(q) {
      const { data } = await axios.get('/apps/chat/chats-and-contacts', {
        params: { q },
      })

      const { chatsContacts, contacts, profileUser } = data

      this.chatsContacts = chatsContacts
      this.contacts = contacts
      this.profileUser = profileUser
    },
  },
})
