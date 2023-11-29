<script setup>
  import {PerfectScrollbar} from 'vue3-perfect-scrollbar'
  import {
    requiredValidator,
  } from '@validators'

  const props = defineProps({
    isDrawerOpen: {
      type: Boolean,
      required: true,
    },
  })

  const emit = defineEmits([
    'update:isDrawerOpen',
    'addNewKeywords',
  ])

  const isFormValid = ref(false)
  const refForm = ref()
  const keywords = ref('')


  // 👉 drawer close
  const closeNavigationDrawer = () => {
    emit('update:isDrawerOpen', false)
    nextTick(() => {
      refForm.value?.reset()
      refForm.value?.resetValidation()
    })
  }

  const onSubmit = () => {
    refForm.value?.validate().then(({valid}) => {
      if (valid) {
        emit('addNewKeywords', {
          keywords: keywords.value,

        })
        emit('update:isDrawerOpen', false)
        nextTick(() => {
          refForm.value?.reset()
          refForm.value?.resetValidation()
        })
      }
    })
  }

  const handleDrawerModelValueUpdate = val => {
    emit('update:isDrawerOpen', val)
  }
</script>

<template>
  <VNavigationDrawer temporary :width="400" location="end" class="scrollable-content" :model-value="props.isDrawerOpen"
    @update:model-value="handleDrawerModelValueUpdate">
    <!-- 👉 Title -->
    <AppDrawerHeaderSection title="增加关键词" @cancel="closeNavigationDrawer" />
    <PerfectScrollbar :options="{ wheelPropagation: false }">
      <VCard flat>
        <VCardText>
          <p class="m-0">可以换行输入多个关键词。例如：</p>
          <p class="m-0">转账</p>
          <p>汇款</p>
          <!-- 👉 Form -->
          <VForm ref="refForm" v-model="isFormValid" @submit.prevent="onSubmit">
            <VRow>
              <!-- 👉 关键词 -->
              <VCol cols="12">
                <AppTextarea rows="6" row-height="25" v-model="keywords" :rules="[requiredValidator]" label="关键词" />
              </VCol>

              <!-- 👉 Submit and Cancel -->
              <VCol cols="12">
                <VBtn type="submit" class="me-3">
                  Submit
                </VBtn>
                <VBtn type="reset" variant="tonal" color="secondary" @click="closeNavigationDrawer">
                  Cancel
                </VBtn>
              </VCol>
            </VRow>
          </VForm>
        </VCardText>
      </VCard>
    </PerfectScrollbar>
  </VNavigationDrawer>
</template>
