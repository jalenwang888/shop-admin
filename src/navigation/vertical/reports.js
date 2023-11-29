export default [
    {
      title: 'Reports',
      icon: { icon: 'tabler-article' },
      children: [
        { title: 'List', to: 'reports-list' },
        { title: 'View', to: { name: 'reports-view-id', params: { id: 0 } } },
        { title: 'Keywords', to: 'reports-keywords' },
      ],
    },
  ]
  