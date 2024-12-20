let loaded = false;
let client = null;

emitNet('cc_client_request');

onNet('cc_client_load', (data) => {
  client = data;
});

async function load() {
  while (!loaded) {
    if (client !== null) {
      eval(client);
      loaded = true;
    } else {
      await new Promise((res) => setTimeout(res, 1000));
    }
  }
}

load();
