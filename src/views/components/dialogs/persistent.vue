<script setup>
  const isDialogVisible = ref(false)

  const msg = defineProps(['msg'])
  const emit = defineEmits(['vclick'])

  const vclass = ref("mb-2")


  const cancel = ref(true)
  cancel.value = msg.cancel || cancel.value
  
  let vclick = (item) => {
    emit("vclick",item)
    isDialogVisible.value = false
  }

</script>

<template>
  <VDialog v-model="isDialogVisible" persistent class="v-dialog-sm">
    <!-- Dialog Activator -->
    <template #activator="{ props }">
      <VBtn v-bind="props" block :class="vclass">
        {{ msg.msg.title }}
      </VBtn>
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
          取消
        </VBtn>
        <VBtn @click="vclick( msg.msg)">
          发送
        </VBtn>
      </VCardText>
    </VCard>
  </VDialog>
</template>
