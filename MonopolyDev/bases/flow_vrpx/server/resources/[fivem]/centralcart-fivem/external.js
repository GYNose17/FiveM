const custom_command = global["custom_command"];

/**
 * Utilize o módulo 'custom_command' para definir as ações que serão executadas em uma nova compra
 * Comandos padrão => ban, unban, addGroup, removeGroup, addMoney, removeMoney, addVehicle, removeVehicle, addHome, removeHome, addItem, jsCode, sqlCode, userNotify
 *
 * IMPORTANTE:
 * Retorne uma string em caso de sucesso ou lance um erro em caso de falha. Se nada for retornado o sistema tentará refazer a entrega.
 */

// Exemplo
/*custom_command["addVehicle"] = async (args) => {
  const user_id = parseInt(args[0]);
  const vehicle_name = args[1];

  console.log("args", args);

  // Vehicle add logic

  const success = true;

  if (success) {
    return "OK";
  } else {
    throw new Error("Falha na entrega do veículo");
  }
};*/

module.exports = this;
