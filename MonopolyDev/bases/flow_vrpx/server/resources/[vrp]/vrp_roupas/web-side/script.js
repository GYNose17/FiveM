let QBClothing = {}

let selectedCam = null;
let clothingCategorys;
let currentMaxValues;
let changingCat;
let currentSex;
let currentColorSelected;

const skinData = {
	pants: { defaultItem: 0, defaultTexture: 0 },
	arms: { defaultItem: 0, defaultTexture: 0 },
	tshirt: { defaultItem: 1, defaultTexture: 0 },
	torso: { defaultItem: 0, defaultTexture: 0 },
	vest: { defaultItem: 0, defaultTexture: 0 },
	backpack: { defaultItem: 0, defaultTexture: 0 },
	shoes: { defaultItem: 1, defaultTexture: 0 },
	mask: { defaultItem: 0, defaultTexture: 0 },
	hat: { defaultItem: -1, defaultTexture: 0 },
	glass: { defaultItem: 0, defaultTexture: 0 },
	ear: { defaultItem: -1, defaultTexture: 0 },
	mochila: { defaultItem: -1, defaultTexture: 0 },
	watch: { defaultItem: -1, defaultTexture: 0 },
	bracelet: { defaultItem: -1, defaultTexture: 0 },
	accessory: { defaultItem: 0, defaultTexture: 0 },
	decals: { defaultItem: 0, defaultTexture: 0 }
}

$(document).on('click', '.set-camera', function(e){
	e.preventDefault();
	let camValue = parseFloat($(this).data('value'));
	if (selectedCam == null) {
		$(this).addClass("selected-cam");
		$.post('http://vrp_roupas/setupCam', JSON.stringify({
			value: camValue
		}));
		selectedCam = this;
	} else {
		if (selectedCam == this) {
			$(selectedCam).removeClass("selected-cam");
			$.post('http://vrp_roupas/setupCam', JSON.stringify({
				value: 0
			}));
			selectedCam = null;
		} else {
			$(selectedCam).removeClass("selected-cam");
			$(this).addClass("selected-cam");
			$.post('http://vrp_roupas/setupCam', JSON.stringify({
				value: camValue
			}));
			selectedCam = this;
		}
	}
});

$(document).ready(function(){
	window.addEventListener('message', function(event) {
		switch(event.data.action) {
			case "open":
				currentSex = event.data.currentGender;
				$("body").fadeIn();
				clothingCategorys = event.data.currentClothing;
				$('#firstClick').click();
				QBClothing.SetCurrentValues(clothingCategorys);
			break;
			case "close":
				$("body").hide();
				QBClothing.Close();
			break;
			case "updateMax":
				currentMaxValues = event.data.maxValues
			break;
		}
	})
});

$(document).on('click', "#save", function(e){
	e.preventDefault();
	QBClothing.Close();
	$.post('http://vrp_roupas/saveClothing');
});

$(document).on('click', "#reset", function(e){
	e.preventDefault();
	QBClothing.Close();
	$.post('http://vrp_roupas/resetOutfit');
});

QBClothing.Close = function() {
	$.post('http://vrp_roupas/close');
  window.location.reload();
}

$(document).on('click', '.shop-item', function(e){
	let clothingCategory = $(this).data('type');
	let newValue = $(this).find('.number').html();
	changingCat = this;

	$('.shop-item').removeClass('active-item');
	$(this).addClass('active-item');

	let max_textures = currentMaxValues[clothingCategory].texture
	$('#texture-label').html('0/'+max_textures)

	$.post('http://vrp_roupas/updateSkin', JSON.stringify({
		clothingType: clothingCategory,
		articleNumber: parseInt(newValue),
		type: 'item',
	}));
});

QBClothing.SetCurrentValues = function(clothingValues) {
	clothingCategorys = clothingValues
	let typesClothes = $('.shop-item').data('type');
	let numberClothes = clothingValues[typesClothes].item;

	$('.shop-item').removeClass('active-item');
	$('#clothe'+numberClothes).addClass('active-item');
}

$(document).on('click', ".category", function(){
	$('.category').removeClass('active');
	$(this).addClass('active');
	$('.invert').html('');

	if ( $('color-shop').is(':visible') ) { $('color-shop').hide('slow') } 
	let typesClothes = $(this).data('type');
	let maxValue = parseInt(currentMaxValues[typesClothes].item);
	
	for(let i = 0; i <= maxValue; i++) {
		//console.log(`http://177.67.83.244/static/skinshop_photos/${currentMaxValues[typesClothes].id}/${capitalizeFirstLetter(currentSex)}/${i}_0.png`)
		// console.log(`http://kushnetwork.com.br/baixada/roupas/${currentSex}/${currentMaxValues[typesClothes].id}/${i}_0.png`)
		// <div class="img" style="background-image: url('http://kushnetwork.com.br/baixada/roupas/${currentSex}/${currentMaxValues[typesClothes].id}/${i}_0.png')"></div>
		// <div class="img" style="background-image: url('http://177.67.83.244/static/skinshop_photos/${currentMaxValues[typesClothes].id}/${capitalizeFirstLetter(currentSex)}/${i}_0.jpg')"></div>

		let currentLink = '';
		if (currentSex == "Male") {
			currentLink = `http://177.54.148.31:4020/roupas/${currentMaxValues[typesClothes].id}/${currentSex}/M(${i}).jpg`
		}else{
			currentLink = `http://177.54.148.31:4020/roupas/${currentMaxValues[typesClothes].id}/${currentSex}/F(${i}).jpg`
		}

		$('.invert').append(`
		<div class="shop-item" id="clothe${i}" data-type="${typesClothes}" data-id="${currentMaxValues[typesClothes].id}">
			<div class="img" style="background-image: url('${currentLink}')"></div>
			<div class="number">${i}</div>
		</div>
		`)
	}
	QBClothing.SetCurrentValues(clothingCategorys);
});

function capitalizeFirstLetter(string) {
	return string.charAt(0).toUpperCase() + string.slice(1);
  }

$(document).on('click', '#color-right', function(e){
	e.preventDefault();
	currentColorSelected = $('#texture-label').data('number');
	let clothingCategory = $(changingCat).data('type');
	let max_textures = currentMaxValues[clothingCategory].texture

	if (currentColorSelected >= max_textures) {
		currentColorSelected = 0
	} else {
		currentColorSelected += 1
	}

	$('#texture-label').html(currentColorSelected+'/'+max_textures)
	$('#texture-label').data('number', currentColorSelected)
	$.post('http://vrp_roupas/updateSkin', JSON.stringify({
		clothingType: clothingCategory,
		articleNumber: currentColorSelected,
		type: 'texture',
	}));
});

$(document).on('click', '#color-left', function(e){
	e.preventDefault();
	currentColorSelected = $('#texture-label').data('number');
	let clothingCategory = $(changingCat).data('type');
	let max_textures = currentMaxValues[clothingCategory].texture

	if (currentColorSelected == 0) {
		currentColorSelected = max_textures
	} else {
		currentColorSelected -= 1
	}

	$('#texture-label').html(currentColorSelected+'/'+max_textures)
	$('#texture-label').data('number', currentColorSelected)
	$.post('http://vrp_roupas/updateSkin', JSON.stringify({
		clothingType: clothingCategory,
		articleNumber: currentColorSelected,
		type: 'texture',
	}));
});

$(document).on('click', '.option', function(e){
	e.preventDefault();
	$('.option').removeClass('active');
	$(this).addClass('active');
	$('.category').hide();
	$('.'+$(this).data('category')).show();
});

$('#rotatePerson').on('input', function (e) {
	$.post('http://vrp_roupas/rotation', JSON.stringify({ camRotation: e.target.value }));
});