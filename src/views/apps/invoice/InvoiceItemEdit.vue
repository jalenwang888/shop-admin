<!-- eslint-disable vue/no-mutating-props -->
<script setup>
const props = defineProps({
  id: {
    type: Number,
    required: true,
  },
  data: {
    type: Object,
    required: true,
    default: () => ({
      title: '',
      cost: 0,
      qty: 1,
      description: '',
    }),
  },
})

const emit = defineEmits([
  'removeProduct',
  'totalAmount',
])

const itemsOptions = [
  {
    title: 'Purchase raw materials'
  },
  {
    title: 'Packaging supplies'
  },
  {
    title: 'Device'
  },
  {
    title: 'Shipping fee'
  },
  {
    title: 'Office Supplies'
  },
  {
    title: 'Rent'
  },
  {
    title: 'Salary'
  },
  {
    title: 'Other'
  },
]



//const localProductData = ref(structuredClone(toRaw(props.data)))

const localProductData = ref(props.data)
const selectedItem = ref(localProductData.value.title)

const setItem1 = (selectedItem,productData) => {
  
  const item = itemsOptions.filter(obj => {
    return obj.title === selectedItem.value
  })

  console.log("Item: "+ JSON.stringify(productData))
  
  localProductData.value = item
  localProductData.value.title = productData.title
  localProductData.value.cost = productData.cost
  localProductData.value.qty = productData.qty
  localProductData.value.description = productData.description

  console.log("localProductData: "+ JSON.stringify(productData))

  props.data.title = productData.title
  props.data.cost = productData.cost
  props.data.qty = productData.qty
  props.data.description = productData.description

}

const setItem = (selectedItem,productData) => {
  
  const item = itemsOptions.filter(obj => {
    return obj.title === selectedItem.value
  })

  localProductData.value.title = productData.title
  localProductData.value.cost = productData.cost
  localProductData.value.qty = productData.qty
  localProductData.value.description = productData.description

  props.data.cost = productData.cost
  props.data.qty = productData.qty
  props.data.description = productData.description

  console.log("Item: "+ JSON.stringify(props.data))


}

watch(selectedItem, () => {
  const item = itemsOptions.filter(obj => {
    return obj.title === selectedItem.value
  })
  
  localProductData.value.title = item[0].title
  console.log("selectedItem: "+ JSON.stringify(localProductData.value.title))

})


const removeProduct = () => {
  emit('removeProduct', props.id)
}

const totalPrice = computed(() => Number(localProductData.value.cost) * Number(localProductData.value.qty))

watch(totalPrice, () => {
  //console.log("total Peice: " + totalPrice.value);
  console.log("Price: "+ JSON.stringify(localProductData.value))

  setItem(selectedItem,localProductData.value)

  emit('totalAmount')
}, { immediate: true })

</script>

<template>
  <!-- eslint-disable vue/no-mutating-props -->
  <div class="add-products-header mb-4 d-none d-md-flex ps-5 pe-16">
    <VRow class="font-weight-medium">
      <VCol
        cols="12"
        md="5"
      >
        <span class="text-base">
          Item
        </span>
      </VCol>

      <VCol
        cols="12"
        md="3"
      >
        <span class="text-base">
          Cost
        </span>
      </VCol>

      <VCol
        cols="12"
        md="2"
      >
        <span class="text-base">
          Qty
        </span>
      </VCol>

      <VCol
        cols="12"
        md="2"
      >
        <span class="text-base">
          Price
        </span>
      </VCol>
    </VRow>
  </div>

  <VCard
    flat
    border
    class="d-flex flex-row"
  >
    <!-- 👉 Left Form -->
    <div class="pa-5 flex-grow-1">
      <VRow>
        <VCol
          cols="12"
          md="6"
        >
        <!--
          <AppSelect
            v-model="selectedItem"
            :items="itemsOptions"
            item-title="title"
            item-value="title"
            label="Select Item"
            class="mb-3"
          />
        -->
        <AppSelect
            v-model="selectedItem"
            :items="itemsOptions"
            item-title="title"
            item-value="title"
            label="Select Item"
            class="mb-3"
          />
          <AppTextarea
            v-model="localProductData.description"
            rows="2"
            label="Description"
            placeholder="Description"
          />
        </VCol>

        <VCol
          cols="12"
          md="2"
          sm="4"
        >
          <AppTextField
            v-model="localProductData.cost"
            type="number"
            label="Cost"
          />
        </VCol>

        <VCol
          cols="12"
          md="2"
          sm="4"
        >
          <AppTextField
            v-model="localProductData.qty"
            type="number"
            label="Qty"
          />
        </VCol>

        <VCol
          cols="12"
          md="2"
          sm="4"
        >
          <p class="my-2">
            <span class="d-inline d-md-none">Price: </span>
            <span class="text-body-1">${{ totalPrice }}</span>
          </p>
        </VCol>
      </VRow>
    </div>

    <!-- 👉 Item Actions -->
    <div class="d-flex flex-column justify-space-between border-s pa-1">
      <IconBtn @click="removeProduct">
        <VIcon
          size="20"
          icon="tabler-x"
        />
      </IconBtn>

      <IconBtn>
        <VIcon
          size="20"
          icon="tabler-settings"
        />
      </IconBtn>
    </div>
  </VCard>
</template>
