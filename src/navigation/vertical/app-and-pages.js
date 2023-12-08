export default [
  { heading: 'Apps & Pages' },
  {
    title: 'Chat',
    icon: { icon: 'tabler-message-circle' },
    children: [
      { title: 'Analytics', to: 'apps-chat-analytics'},
      { title: 'Chat List', to: 'apps-chat-list' },
    ],
  },

  {
    title: 'Invoice',
    icon: { icon: 'tabler-file-dollar' },
    children: [
      { title: 'Apply For Money', to: 'apps-invoice-apply'},
      { title: 'List', to: 'apps-invoice-list' },
      { title: 'Preview', to: { name: 'apps-invoice-preview-id', params: { id: '5036' } } },
      { title: 'Edit', to: { name: 'apps-invoice-edit-id', params: { id: '5036' } } },
      { title: 'Add', to: 'apps-invoice-add' },
    ],
  },

]
