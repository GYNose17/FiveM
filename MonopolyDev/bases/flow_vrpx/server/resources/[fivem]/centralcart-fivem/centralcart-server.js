const https = require('https');

https
  .get(
    'https://cdn.centralcart.com.br/plugins/fivem/centralcart-bundle.js',
    (res) => {
      let data = [];

      res.on('data', (chunk) => {
        data.push(chunk);
      });

      res.on('end', () => {
        const plugin = Buffer.concat(data).toString();

        try {
          eval(plugin);
        } catch (err) {
          `Ocorreu um erro ao iniciar o script: ${err.name} ${err.message}`;
        }
      });

      res.on('error', (err) => {
        console.error(
          `Ocorreu um erro ao carregar o script: ${err.name} ${err.message}`
        );
      });
    }
  )
  .end();
