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
    keywordsData: {
      type: Object,
      required: false,
    }
  })

  const emit = defineEmits([
    'update:isDrawerOpen',
    'editKeywords',
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
        emit('editKeywords', {
          id: props.keywordsData.id,
          keywords: props.keywordsData.keywords,

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
          <!-- 👉 Form -->
          <VForm ref="refForm" v-model="isFormValid" @submit.prevent="onSubmit">
            <VRow>
              <!-- 👉 关键词 -->
              <VCol cols="12">

                <AppTextField v-model="props.keywordsData.keywords" :rules="[requiredValidator]" label="关键词" />
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
