<script setup>
  const isDialogVisible = ref(false)

  const msg = defineProps(['msg','item'])
  const emit = defineEmits(['vclick'])

  const cancel = ref(true)
  cancel.value = msg.cancel || cancel.value
  
  let vclick = (n, item) => {
    emit("vclick", n, item)
    isDialogVisible.value = false
  }

</script>

<template>
  <VDialog v-model="isDialogVisible" persistent class="v-dialog-sm">
    <!-- Dialog Activator -->
    <template #activator="{ props }">

      <IconBtn  v-bind="props">
          <VIcon :icon="msg.msg.icon" />
        </IconBtn>

    </template>

    <!-- Dialog close btn -->
    <DialogCloseBtn @click="isDialogVisible = !isDialogVisible" />

    <!-- Dialog Content -->
    <VCard :title="msg.msg.alertTitle">
      <VCardText>
      
        {{ msg.msg.content }}
      </VCardText>

      <VCardText class="d-flex justify-end gap-3 flex-wrap">
        <VBtn color="secondary" variant="tonal" @click="isDialogVisible = false" v-if="cancel">
          {{ msg.msg.cancel }}
        </VBtn>
        <VBtn @click="vclick(msg.msg, msg.item)">
          {{ msg.msg.confirm  }}
        </VBtn>
      </VCardText>
    </VCard>
  </VDialog>
</template>
