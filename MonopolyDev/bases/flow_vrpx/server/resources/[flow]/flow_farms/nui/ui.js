let bancada = null;

$(document).ready(function(){
	var actionContainer = $(".actionmenu");

	window.addEventListener("message",function(event){
	  var data = event.data;

	  if (data.showmenu) {
		$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
		$(".nameBancada").html(data.bancada);

        bancada = data.bancadaName;
        console.log(bancada)

		const nameList = data.itens
		$('.conteudoItens').html(`
			${nameList.map((item) => (`
				<div class="itemSessao item-item" category="armas">
				<div class="item-info">
					<div class="fotoItem">
						<img src="http://104.234.65.51:/ultimate/inventario/${item.id}.png">
					</div> 
					<div class="produzir">
						<button onclick="fabricarItem('${item.id}', '${item.minAmount}', '${item.maxAmount}')"><b>Iniciar</b></button>
					</div>
			</div>
			`)).join('')}
		`);

		actionContainer.fadeIn();
	  }

      if (data.hidemenu) {
        $('body').css('background-color', 'transparent')
        actionContainer.fadeOut();
        $.post('http://flow_farms/closeNui',JSON.stringify({}))
      }
  
	  $('.button-close').click(function(e){
			if (actionContainer.is(":visible")) {
				$('body').css('background-color', 'transparent')
				actionContainer.fadeOut();
				$.post('http://flow_farms/closeNui',JSON.stringify({}))
			}
		});
	});
  
	document.onkeyup = function(data) {
	  if (data.which == 27) {
		if (actionContainer.is(":visible")) {
			$('body').css('background-color', 'transparent')
			actionContainer.fadeOut();
			$.post('http://flow_farms/closeNui',JSON.stringify({}))
		}
	  }
	};

	
});


function fabricarItem(item, minAmount, maxAmount) {
    $.post('http://flow_farms/fabricarItem', JSON.stringify({ item: item, minAmount: minAmount, maxAmount: maxAmount, bancada: bancada }))
}