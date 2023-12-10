<script setup>
import InvoiceItemEdit from './InvoiceItemEdit.vue'
import { useInvoiceStore } from './useInvoiceStore'
import { VNodeRenderer } from '@layouts/components/VNodeRenderer'
import { themeConfig } from '@themeConfig'

const props = defineProps({
  data: {
    type: null,
    required: true,
  },
})

const invoiceListStore = useInvoiceStore()

// 👉 Clients
const clients = ref([])

const isFormValid = ref(false)
const refForm = ref()
const subtotal = ref(0)
const refreshKey = ref(0); // 刷新的 key

const addThousandSeparator = (number) => {
  // 使用正则表达式添加千位符
  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
};

const paymentMethods = [
  'Cash',
  'Gcash',
  'AUB',
  'EastWest',
  'BDO',
]


// 👉 fetchClients
invoiceListStore.fetchClients().then(response => {
  clients.value = response.data
}).catch(err => {
})

// 👉 Add item function
const addItem = () => {
  // eslint-disable-next-line vue/no-mutating-props
  props.data.purchasedProducts.push({
    title: '',
    cost: 0,
    qty: 1,
    description: '',
  })
}


const removeProduct = id => {

  // eslint-disable-next-line vue/no-mutating-props
  refreshKey.value += 1;
  
  props.data.purchasedProducts.splice(id, 1)

  totalAmount()
}

const totalAmount = () => {
  subtotal.value = 0
  props.data.purchasedProducts.forEach((product, index) => {
    console.log("totalAmount: "+ JSON.stringify(product))

    subtotal.value  +=  (Number(product.cost) * Number(product.qty))
    props.data.paymentDetails.totalDue = subtotal.value
  })
}
</script>

<template>
  <VCard>
    <!-- SECTION Header -->
    <!--  eslint-disable vue/no-mutating-props -->
    <VCardText class="d-flex flex-wrap justify-space-between gap-y-5 flex-column flex-sm-row">
      <!-- 👉 Left Content -->
      <div class="ma-sm-4">
        <div class="d-flex align-center mb-6">
          <!-- 👉 Logo -->
          <VNodeRenderer
            :nodes="themeConfig.app.logo"
            class="me-3"
          />

          <!-- 👉 Title -->
          <h6 class="font-weight-bold text-capitalize text-h4">
            {{ themeConfig.app.title }}
          </h6>
        </div>

        <!-- 👉 Address -->
        <!-- 
        <p class="mb-0">
          Office 149, 450 South Brand Brooklyn
        </p>
        <p class="my-2">
          San Diego County, CA 91905, USA
        </p>
        <p class="mb-0">
          +1 (123) 456 7891, +44 (876) 543 2198
        </p>
        -->
      </div>

      <!-- 👉 Right Content -->
      <div class="mt-4 ma-sm-4">
        <!-- 👉 Invoice Id -->
        <h6 class="d-flex align-center font-weight-medium justify-sm-end text-xl mb-3">
          <span
            class="me-3 text-h4"
            style="inline-size: 6rem;"
          >Invoice</span>

          <span>
            <AppTextField
              v-model="props.data.invoice.id"
              disabled
              prefix="#"
              density="compact"
              style="inline-size: 9.5rem;"
            />
          </span>
        </h6>

        <!-- 👉 Issue Date -->
        <p class="d-flex align-center justify-sm-end mb-3">
          <span
            class="me-3"
            style="inline-size: 6rem;"
          >Date Issued</span>

          <span style="inline-size: 9.5rem;">
            <AppDateTimePicker
              v-model="props.data.invoice.issuedDate"
              density="compact"
              placeholder="YYYY-MM-DD"
              :config="{ position: 'auto right' }"
            />
          </span>
        </p>

        <!-- 👉 Due Date -->
        <p class="d-flex align-center justify-sm-end mb-0">
          <span
            class="me-3"
            style="inline-size: 6rem;"
          >Due Date</span>

          <span style="min-inline-size: 9.5rem;">
            <AppDateTimePicker
              v-model="props.data.invoice.dueDate"
              density="compact"
              placeholder="YYYY-MM-DD"
              :config="{ position: 'auto right' }"
            />
          </span>
        </p>
      </div>
    </VCardText>
    <!-- !SECTION -->


    <!-- 👉 Add purchased products -->
    <VCardText class="add-products-form">
      <div :key="refreshKey">
        <div
          v-for="(product, index) in props.data.purchasedProducts"
          :key="product.title"
          class="my-4 ma-sm-4"
        >
          <InvoiceItemEdit
            :id="index"
            :data="product"
            @remove-product="removeProduct"
            @total-amount="totalAmount"
          />
        </div>
      </div>

      <div class="mt-4 ma-sm-4">
        <VBtn @click="addItem">
          Add Item
        </VBtn>
      </div>
    </VCardText>

    <VDivider />

    <!-- 👉 Total Amount -->
    <VCardText class="d-flex justify-space-between flex-wrap flex-column flex-sm-row">
      <div class="mx-sm-4 my-4 v-col-sm-6 v-col-lg-4 v-col-12">
        <div class="app-select flex-grow-1 mb-5">
          
            <!-- 👉 Select payment method -->
            <AppSelect
              v-model="props.data.paymentDetails.bankName"
              :items="paymentMethods"
              label="Accept Payment Via"
              class="mb-6"
            />

        </div>
        <VRow>
        <VCol
          cols="12"
          md="6"
        >
        <AppTextField
          v-model="props.data.paymentDetails.fullName"
          placeholder="Full Name"
        />
        </VCol>
        <VCol
          cols="12"
          md="6"
        >
        <AppTextField
          v-model="props.data.paymentDetails.account"
          placeholder="Account"
        />
        </VCol>
        </VRow>
      </div>

      <div class="my-4 mx-sm-4">
        <table>
          <tr>
            <td class="text-end">
              <div class="me-5">
                <p class="mb-2">
                  Subtotal:
                </p>
                <p class="mb-2">
                  Discount:
                </p>
                <p class="mb-2">
                  Tax:
                </p>
                <p class="mb-2">
                  Total:
                </p>
              </div>
            </td>

            <td class="font-weight-medium text-high-emphasis">
              <p class="mb-2">
                {{ addThousandSeparator(subtotal) }}
              </p>
              <p class="mb-2">
                00.00
              </p>
              <p class="mb-2">
                00.00
              </p>
              <p class="mb-2">
                {{ addThousandSeparator(subtotal) }}
              </p>
            </td>
          </tr>
        </table>
      </div>
    </VCardText>

    <VDivider />

    <VCardText class="mx-sm-4">
      <p class="font-weight-medium text-sm text-high-emphasis mb-2">
        Note:
      </p>
      <AppTextarea
        v-model="props.data.note"
        placeholder="Note"
        :rows="2"
      />
    </VCardText>
  </VCard>
</template>
