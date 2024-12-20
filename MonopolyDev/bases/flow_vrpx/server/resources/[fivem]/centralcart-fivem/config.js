module.exports = {
  server_identifier: "c34f9838-2fc6-443a-9058-2abc40218d23", // Informe o token da sua loja. Caso ainda não o tenha acesse https://centralcart.com.br/app/settings/plugin para obtê-lo

  vip_command: "vip", // Defina o comando para ver o tempo restante dos produtos

  // Personalizações
  notify_animation: "DEFAULT", // Opções de notificações: DISABLED - DEFAULT
  notify_text: "A compra de {products} foi concluída!",
  notify_position: "TOP_RIGHT",
  global_notify: true, // Defina se uma mensagem global será enviada quando houver uma nova compra

  chat_text: "{name} comprou {products} na nossa loja!",
  chat_icon: "https://cdn.centralcart.com.br/plugins/fivem/web/assets/cart.svg",
  chat_style: [
    "font-size: 16px",
    "display: flex",
    "align-items: center",
    "padding: 0.7vw",
    "background-image: linear-gradient(to right, #00dc82 3%, rgba(0, 0, 0,0) 95%)",
    "border-radius: 5px",
  ],

  vrp_script_name: "vrp",

  // Opções avançadas
  debug_mode: false,
};
