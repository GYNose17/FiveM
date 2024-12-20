var dir = '';
var inBuy = false;
var permitBuy = true;

var velo_max = new ldBar(".velo_max",
    {
        "value": 60,
        "fill-background-extrude": 0,
        "fill": 'blue',
        "fill-dir": 'ltr',
        "type": 'fill',
        "min": 1,
        "max": 100,
    }
);
var frenagem = new ldBar(".frenagem",
    {
        "value": 60,
        "fill-background-extrude": 0,
        "fill": 'blue',
        "fill-dir": 'ltr',
        "type": 'fill',
        "min": 1,
        "max": 100,
    }
);
var agilidade = new ldBar(".agilidade",
    {
        "value": 60,
        "fill-background-extrude": 0,
        "fill": 'blue',
        "fill-dir": 'ltr',
        "type": 'fill',
        "min": 1,
        "max": 100,
    }
);
var aderencia = new ldBar(".aderencia",
    {
        "value": 60,
        "fill-background-extrude": 0,
        "fill": 'blue',
        "fill-dir": 'ltr',
        "type": 'fill',
        "min": 1,
        "max": 100,
    }
);



function selectMenu(selected) {
    permitBuy = true

    if (selected == 'vip') {
        permitBuy = false
    }

    if (selected != 'vip') {
        $('.buy_bottom').show(); $('.test').css('width', '40%');
    }

    if (selected == 'meus') {
        inBuy = false;
        $.post("http://bm_module/requestMyVehicles", JSON.stringify({}), (data) => {
            $('.buy_bottom').addClass('cancel');
            $('.buy_bottom').removeClass('buy');
            $('.buy_bottom').html('Vender')
            $('.question h3').html('Você tem certeza que deseja VENDER este veiculo?')
            let newVehicles = data.list
            if (newVehicles != undefined) {

                let maxspeed = newVehicles[0].maxspeed * 100 / 550 || 0
                let agility = newVehicles[0].agility * 100 || 0
                let braking = newVehicles[0].braking * 10 || 0
                let aceleration = newVehicles[0].aceleration * 100 || 0
                var formato = { minimumFractionDigits: 0, style: 'currency', currency: 'BRL' }
                velo_max.set(maxspeed)
                agilidade.set(agility)
                frenagem.set(braking)
                aderencia.set(aceleration)

                $('.img_car_conce').attr('src', data.dir + newVehicles[0].spawn + '.png')
                $('.value_conce').html(`
                    <img src="dealership/nui/images/money.png" alt="a">
                    ${newVehicles[0].price.toLocaleString('pt-BR', formato)}
                `)
                $('.trunk_conce').html(`
                    <img src="dealership/nui/images/trunk.png" alt="a">
                    ${newVehicles[0].trunk}KG
                `)


                $('.nameShow_conce').html(newVehicles[0].name.toUpperCase())
                $('.right_conce').html('');

                dir = data.dir


                newVehicles.map((item, index) => {
                    $('.right_conce').append(`
                        <div class="item_car_conce ${item.spawn}" data-value="${item.price}"  data-trunk="${item.trunk}"  data-spawn="${item.spawn}" data-maxspeed='${item.maxspeed}' data-ipva='${item.ipva}' data-detido='${item.status}' data-favorite='${item.favorite}'  data-agility='${item.agility}' data-braking='${item.braking}' data-aceleration='${item.aceleration}' data-fuel='${item.fuel}' data-engine='${item.engine}' data-body='${item.body}'
                        onclick="selectVehicle('${item.spawn}')" >
                            <div class="name_conce">
                                ${item.name.toUpperCase()}
                            </div>
                            <img class="img_car_conce" src="${data.dir}${item.spawn}.png"  onerror="this.src='garages/nui/images/default.png'"  alt="">
                        </div>
                    `)
                })

                $('.' + newVehicles[0].spawn).addClass('item_car_select')
            }

        });
        $('.test').hide();
        $('.buy_bottom').css('width', '100%');

    }

    if (selected != 'meus') {
        inBuy = true;
        $.post("http://bm_module/requestConceVehicles", JSON.stringify({}), (data) => {
            let newVehicles = data.list.filter((item) => item.type === selected)
            $('.buy_bottom').addClass('buy');
            $('.buy_bottom').removeClass('cancel');
            if (selected == "vip") {
                $('.buy_bottom').html('Acessar')
            } else {
                $('.buy_bottom').html('Comprar')
            }
            $('.question h3').html('Você tem certeza que deseja COMPRAR este veiculo?')

            if (newVehicles) {

                let maxspeed = newVehicles[0].maxspeed * 100 / 550 || 0
                let agility = newVehicles[0].agility * 100 || 0
                let braking = newVehicles[0].braking * 10 || 0
                let aceleration = newVehicles[0].aceleration * 100 || 0

                var formato = { minimumFractionDigits: 0 , style: 'currency', currency: 'BRL' }
                velo_max.set(maxspeed)
                agilidade.set(agility)
                frenagem.set(braking)
                aderencia.set(aceleration)

                $('.img_car_conce').attr('src', data.dir + newVehicles[0].spawn + '.png')
                $('.right_conce').html('');
                $('.nameShow_conce').html(newVehicles[0].name.toUpperCase())
                $('.value_conce').html(`
                    <img src="dealership/nui/images/money.png" alt="">
                    ${newVehicles[0].price.toLocaleString('pt-BR', formato)}
                `)

                $('.trunk_conce').html(`
                    <img src="dealership/nui/images/trunk.png" alt="a">
                    ${newVehicles[0].trunk}KG
                `)
                dir = data.dir

                newVehicles.map((item, index) => {
                    $('.right_conce').append(`
                        <div class="item_car_conce ${item.spawn}" data-value="${item.price}" data-trunk="${item.trunk}" data-spawn="${item.spawn}" data-maxspeed='${item.maxspeed}' data-ipva='${item.ipva}' data-detido='${item.status}' data-favorite='${item.favorite}'  data-agility='${item.agility}' data-braking='${item.braking}' data-aceleration='${item.aceleration}' data-fuel='${item.fuel}' data-engine='${item.engine}' data-body='${item.body}'
                        onclick="selectVehicle('${item.spawn}')" >
                            <div class="name_conce">
                                ${item.name.toUpperCase()}
                            </div>
                            <img class="img_car_conce" src="${data.dir}${item.spawn}.png"  onerror="this.src='garages/nui/images/default.png'"  alt="">
                        </div>
                    `)
                })

                $('.' + newVehicles[0].spawn).addClass('item_car_select')
            }


        });
        $('.test').fadeIn();
        $('.buy_bottom').css('width', '5.989583333333334vw');
    }


    $('.content_select_conce').hide();
    $('.content_conce').css('opacity', '1');
}


function selectVehicle(vehicle) {
    $('.item_car_select').removeClass('item_car_select')
    $('.' + vehicle).addClass('item_car_select')
    $('.item_car_select').data('name', vehicle)
    $('.nameShow_conce').html($('.item_car_select').data('name').toUpperCase())
    let maxspeed = $('.' + vehicle).data('maxspeed') * 100 / 550 || 0
    let agility = $('.' + vehicle).data('agility') * 100 || 0
    let braking = $('.' + vehicle).data('braking') * 10 || 0
    let aceleration = $('.' + vehicle).data('aceleration') * 100 || 0

    var formato = { minimumFractionDigits: 0, style: 'currency', currency: 'BRL' }
    $('.showimg_car_conce').attr('src', dir + vehicle + '.png')
    $('.value_conce').html(`
        <img src="dealership/nui/images/money.png" alt="">
        ${$('.' + vehicle).data('value').toLocaleString('pt-BR', formato)}
    `)

    $('.trunk_conce').html(`
    <img src="dealership/nui/images/trunk.png" alt="a">
    ${$('.' + vehicle).data('trunk')}KG
`)

    velo_max.set(maxspeed)
    agilidade.set(agility)
    frenagem.set(braking)
    aderencia.set(aceleration)
}

function backItem() {
    $('.content_conce').css('opacity', '0');
    $('.content_select_conce').fadeIn();
    $('.right_conce').html('');
}

function buyVehicle() {
    if (!permitBuy) {
        window.invokeNative("openUrl", "https://five-m.store/loja/") //SUA LOJA DO FIVEM
        return
    }

    $('.modal_buy_conce').css('display', 'flex')
    $('.modal_buy_conce').fadeIn(500)

    $('.showModal_conce').attr('src', dir + $('.item_car_select').data('spawn') + '.png')
    $('.value_modal_conce').html('R$' + $('.item_car_select').data('value'))
}

function confirmBuy() {
    if (inBuy == true) {
        $.post("http://bm_module/buyVehicle", JSON.stringify({
            vehicle: $('.item_car_select').data('spawn')
        }))
    } else {
        $.post("http://bm_module/sellVehicle", JSON.stringify({
            vehicle: $('.item_car_select').data('spawn')
        }))
    }
    backItem()
    $('.modal_buy_conce').hide()
}

function cancelBuy() {
    $('.modal_buy_conce').fadeOut(500)
}

function testDrive() {
    $.post("http://bm_module/testDrive", JSON.stringify({
        vehicle: $('.item_car_select').data('spawn')
    }))
    backItem()
}

$(".search_conce").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $('.right_conce .item_car_conce').filter(function () {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    })
})


