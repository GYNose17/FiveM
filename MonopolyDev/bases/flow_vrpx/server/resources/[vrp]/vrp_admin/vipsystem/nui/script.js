$(document).ready(() => {
    window.addEventListener('message', function ({data}) {
        if(data.action == 'vipsystem'){
            openVipSystem()
        }
    });
})

const openVipSystem = () => {
    window.invokeNative("openUrl", "https://pratazikacurso.centralcart.com.br/") //link da sua loja 
}