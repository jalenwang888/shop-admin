<script setup>
import InvoiceEditable from '@/views/apps/invoice/InvoiceApply.vue'

const invoiceData = ref({
  invoice: {
    id: 5037,
    issuedDate: '',
    service: '',
    total: 0,
    avatar: '',
    invoiceStatus: '',
    dueDate: '',
    balance: 0,
    client: {
      address: '',
      company: '',
      companyEmail: '',
      contact: '',
      country: '',
      name: '',
    },
  },
  paymentDetails: {
    totalDue: '',
    bankName: 'Gcash',
    country: '',
    iban: '',
    swiftCode: '',
  },
  purchasedProducts: [{
    title: '',
    cost: 0,
    qty: 1,
    description: '',
  }],
  note: '',
  paymentMethod: '',
  salesperson: '',
  thanksNote: '',
})

const paymentTerms = ref(true)
const clientNotes = ref(false)
const paymentStub = ref(false)

const refForm = ref()
const isFormValid = ref(true)

const onSubmit = () => {
  console.log("SUBMIT"+JSON.stringify(invoiceData.value))
}

</script>

<template>
  <!-- 👉 Form -->
  <VForm ref="refForm" v-model="isFormValid" @submit.prevent="onSubmit">
  <VRow>
    <!-- 👉 InvoiceEditable -->
    <VCol
      cols="12"
      md="9"
    >
      <InvoiceEditable :data="invoiceData" />
    </VCol>

    <!-- 👉 Right Column: Invoice Action -->
    <VCol
      cols="12"
      md="3"
    >
      <VCard class="mb-8">
        <VCardText>
          <!-- 👉 Send Application -->
          <VBtn type="submit" 
            block
            prepend-icon="tabler-send"
            class="mb-2"
          >
            Send Application
          </VBtn>
        </VCardText>
      </VCard>
    </VCol>
  </VRow>
  </VForm>
</template>
