export const activeVariant = (stat) => {
    if (stat === 1) return {"text": "Active", "color":  "success"}
    if (stat === 0)  return {"text": "Inactive", "color":  "secondary"}

    return {"text": "NULL", "color":  "secondary"}
}
  