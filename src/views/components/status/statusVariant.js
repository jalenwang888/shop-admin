export const statusVariant = (stat) => {
  const statLowerCase = stat.toLowerCase();
  if (statLowerCase === "new") return "secondary";
  if (statLowerCase === "warn") return "warning";

  //禁言
  if (statLowerCase === "stopspeaker") return "info";
  if (statLowerCase === "closure") return "error";


  return "primary";
};
