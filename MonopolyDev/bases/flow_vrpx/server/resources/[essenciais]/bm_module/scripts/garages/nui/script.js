$(document).ready(function () {
    requestCars()
})

var pending = false;
var dir = '';
var isPublic = true;

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
var gasolina = new ldBar(".gasolina",
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
var motor = new ldBar(".motor",
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
var lataria = new ldBar(".lataria",
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

var custom = {
    engine: false,
    breaking: false,
    transmission: false,
    suspension: false,
    shielding: false,
    turbo: false
}

function requestCars() {
    $.post("http://bm_module/requestGarages", JSON.stringify({}), (data) => {
        let maxspeed = data.cars[0].maxspeed * 100 / 550 || 0
        let agility = data.cars[0].agility * 100 || 0
        let braking = data.cars[0].braking * 10 || 0
        let aceleration = data.cars[0].aceleration * 100 || 0
        let gas = data.cars[0].fuel || 0
        let engine = data.cars[0].engine || 0
        let body = data.cars[0].body || 0
        let ipva = data.cars[0].ipva || 0
        let detido = data.cars[0].status || 0

        if (data.cars[0].custom && data.cars[0].custom.mods) {
            custom.engine = data.cars[0].custom.mods[11]['mod'] ? true : false
            custom.breaking = data.cars[0].custom.mods[12]['mod'] ? true : false
            custom.transmission = data.cars[0].custom.mods[13]['mod'] ? true : false
            custom.suspension = data.cars[0].custom.mods[15]['mod'] ? true : false
            custom.shielding = data.cars[0].custom.mods[16]['mod'] ? true : false
            custom.turbo = data.cars[0].custom.mods[18]['mod'] ? true : false
        }

        if (custom.engine == true) {
            $('.custom_engine .progress_custom').addClass('yess_preview');
            $('.custom_engine .progress_custom').removeClass('no_preview');
            $('.custom_engine p').html('Ativado');
        } else {
            $('.custom_engine .progress_custom').addClass('no_preview');
            $('.custom_engine .progress_custom').removeClass('yess_preview');
            $('.custom_engine p').html('Desativado');
        }

        if (custom.breaking == true) {
            $('.custom_breaking .progress_custom').addClass('yess_preview');
            $('.custom_breaking .progress_custom').removeClass('no_preview');
            $('.custom_breaking p').html('Ativado');
        } else {
            $('.custom_breaking .progress_custom').addClass('no_preview');
            $('.custom_breaking .progress_custom').removeClass('yess_preview');
            $('.custom_breaking p').html('Desativado');
        }

        if (custom.transmission == true) {
            $('.custom_transmission .progress_custom').addClass('yess_preview');
            $('.custom_transmission .progress_custom').removeClass('no_preview');
            $('.custom_transmission p').html('Ativado');
        } else {
            $('.custom_transmission .progress_custom').addClass('no_preview');
            $('.custom_transmission .progress_custom').removeClass('yess_preview');
            $('.custom_transmission p').html('Desativado');
        }

        if (custom.suspension == true) {
            $('.custom_suspension .progress_custom').addClass('yess_preview');
            $('.custom_suspension .progress_custom').removeClass('no_preview');
            $('.custom_suspension p').html('Ativado');
        } else {
            $('.custom_suspension .progress_custom').addClass('no_preview');
            $('.custom_suspension .progress_custom').removeClass('yess_preview');
            $('.custom_suspension p').html('Desativado');
        }

        if (custom.shielding == true) {
            $('.custom_shielding .progress_custom').addClass('yess_preview');
            $('.custom_shielding .progress_custom').removeClass('no_preview');
            $('.custom_shielding p').html('Ativado');
        } else {
            $('.custom_shielding .progress_custom').addClass('no_preview');
            $('.custom_shielding .progress_custom').removeClass('yess_preview');
            $('.custom_shielding p').html('Desativado');
        }

        if (custom.turbo == true) {
            $('.custom_turbo .progress_custom').addClass('yess_preview');
            $('.custom_turbo p').html('Ativado');
            $('.custom_turbo .progress_custom').removeClass('no_preview');
        } else {
            $('.custom_turbo .progress_custom').addClass('no_preview');
            $('.custom_turbo .progress_custom').removeClass('yess_preview');
            $('.custom_turbo p').html('Desativado');
        }

        if (ipva == true) {
            pending = true;
            $('.ipva').removeClass('no_preview')
            $('.ipva').addClass('yess_preview')
        } else {
            pending = false;
            $('.ipva').addClass('no_preview')
            $('.ipva').removeClass('yess_preview')
        }

        if (detido == true) {
            pending = true;
            $('.detido').removeClass('no_preview')
            $('.detido').addClass('yess_preview')
        } else {
            pending = false;
            $('.detido').addClass('no_preview')
            $('.detido').removeClass('yess_preview')
        }

        velo_max.set(maxspeed)
        agilidade.set(agility)
        frenagem.set(braking)
        aderencia.set(aceleration)
        gasolina.set(gas)
        motor.set(engine)
        lataria.set(body)

        dir = data.dir
        $('.showroom_garagem img').attr('src', data.dir + data.cars[0].vehicle + '.png')
        $('.right_garagem').html('');

        if(data.isPublic == true) {
            isPublic = true
        }else{
            isPublic = false
        }

        data.cars.map((item, index) => {
            $('.right_garagem').append(`
                <div class="item_car_garagem ${item.vehicle}" data-tengine="${item.custom.mods && item.custom.mods[11] ? true : false}" data-tbreaking="${item.custom.mods && item.custom.mods[12] ? true : false}" data-ttransmission="${item.custom.mods && item.custom.mods[13] ? true : false}" data-tsuspension="${item.custom.mods && item.custom.mods[15] ? true : false}" data-tshielding="${item.custom.mods && item.custom.mods[16] ? true : false}" data-tturbo="${item.custom.mods && item.custom.mods[18] ? true : false}" data-maxspeed='${item.maxspeed}' data-ipva='${item.ipva}' data-detido='${item.status}' data-favorite='${item.favorite}'  data-agility='${item.agility}' data-braking='${item.braking}' data-aceleration='${item.aceleration}' data-fuel='${item.fuel}' data-engine='${item.engine}' data-body='${item.body}'
                    onclick="selectVehicle('${item.vehicle}', ${item.ipva}, ${item.status})" >
                    <div class="name_garagem">
                        ${item.vehicle.toUpperCase()}
                    </div>
                    <img class="favorite_garagem" src="garages/nui/images/favorite.svg" alt="" onclick="setFavorite('${item.vehicle}')">
                    <img class="img_car_garagem" src="${data.dir}${item.vehicle}.png"  onerror="this.src='garages/nui/images/default.png'"  alt="">
                </div>
            `)
        })

        $('.' + data.cars[0].vehicle).addClass('item_car_select')
        $('.item_car_select').data('name', data.cars[0].vehicle)

        if (data.cars[0].ipva == true) {
            pending = true;
        }

        if (data.cars[0].status == true) {
            pending = true;
        }

        for (let i = 0; i < data.cars.length; i++) {
            if (data.cars[i].favorite == true) {
                $('.' + data.cars[i].vehicle + ' .favorite_garagem').attr('src', 'garages/nui/images/yes_favorite.svg')
            } else {
                $('.' + data.cars[i].vehicle + ' .favorite_garagem').attr('src', 'garages/nui/images/favorite.svg')
            }
        }
    });
}
function selectPreview(target, tuning) {
    $('.select_preview').removeClass('select_preview');
    $(target).addClass('select_preview');

    if (tuning == false) {
        $('.data_geral').css('opacity', '1');
        $('.data_tuning').css('opacity', '0');
    }


    if (tuning == true) {
        $('.data_geral').css('opacity', '0');
        $('.data_tuning').css('opacity', '1');
    }
}
function selectVehicle(vehicle, ipva, detido) {
    $('.item_car_select').removeClass('item_car_select')
    $('.' + vehicle).addClass('item_car_select')
    $('.item_car_select').data('name', vehicle)
    let maxspeed = $('.' + vehicle).data('maxspeed') * 100 / 550 || 0
    let agility = $('.' + vehicle).data('agility') * 100 || 0
    let braking = $('.' + vehicle).data('braking') * 10 || 0
    let aceleration = $('.' + vehicle).data('aceleration') * 100 || 0
    let gas = $('.' + vehicle).data('fuel') || 0
    let engine = $('.' + vehicle).data('engine') || 0
    let body = $('.' + vehicle).data('body') || 0

    custom.engine = $('.' + vehicle).data('tengine')
    custom.breaking = $('.' + vehicle).data('tbreaking')
    custom.transmission = $('.' + vehicle).data('ttransmission')
    custom.suspension = $('.' + vehicle).data('tsuspension')
    custom.shielding = $('.' + vehicle).data('tshielding')
    custom.turbo = $('.' + vehicle).data('tturbo')


    if (custom.engine == true) {
        $('.custom_engine .progress_custom').addClass('yess_preview');
        $('.custom_engine .progress_custom').removeClass('no_preview');
        $('.custom_engine p').html('Ativado');
    } else {
        $('.custom_engine .progress_custom').addClass('no_preview');
        $('.custom_engine .progress_custom').removeClass('yess_preview');
        $('.custom_engine p').html('Desativado');
    }

    if (custom.breaking == true) {
        $('.custom_breaking .progress_custom').addClass('yess_preview');
        $('.custom_breaking .progress_custom').removeClass('no_preview');
        $('.custom_breaking p').html('Ativado');
    } else {
        $('.custom_breaking .progress_custom').addClass('no_preview');
        $('.custom_breaking .progress_custom').removeClass('yess_preview');
        $('.custom_breaking p').html('Desativado');
    }

    if (custom.transmission == true) {
        $('.custom_transmission .progress_custom').addClass('yess_preview');
        $('.custom_transmission .progress_custom').removeClass('no_preview');
        $('.custom_transmission p').html('Ativado');
    } else {
        $('.custom_transmission .progress_custom').addClass('no_preview');
        $('.custom_transmission .progress_custom').removeClass('yess_preview');
        $('.custom_transmission p').html('Desativado');
    }

    if (custom.suspension == true) {
        $('.custom_suspension .progress_custom').addClass('yess_preview');
        $('.custom_suspension .progress_custom').removeClass('no_preview');
        $('.custom_suspension p').html('Ativado');
    } else {
        $('.custom_suspension .progress_custom').addClass('no_preview');
        $('.custom_suspension .progress_custom').removeClass('yess_preview');
        $('.custom_suspension p').html('Desativado');
    }

    if (custom.shielding == true) {
        $('.custom_shielding .progress_custom').addClass('yess_preview');
        $('.custom_shielding .progress_custom').removeClass('no_preview');
        $('.custom_shielding p').html('Ativado');
    } else {
        $('.custom_shielding .progress_custom').addClass('no_preview');
        $('.custom_shielding .progress_custom').removeClass('yess_preview');
        $('.custom_shielding p').html('Desativado');
    }

    if (custom.turbo == true) {
        $('.custom_turbo .progress_custom').addClass('yess_preview');
        $('.custom_turbo p').html('Ativado');
        $('.custom_turbo .progress_custom').removeClass('no_preview');
    } else {
        $('.custom_turbo .progress_custom').addClass('no_preview');
        $('.custom_turbo .progress_custom').removeClass('yess_preview');
        $('.custom_turbo p').html('Desativado');
    }


    if (ipva == true) {
        pending = true;
        $('.ipva').removeClass('no_preview')
        $('.ipva').addClass('yess_preview')
    } else {
        pending = false;
        $('.ipva').addClass('no_preview')
        $('.ipva').removeClass('yess_preview')
    }

    if (detido == true) {
        pending = true;
        $('.detido').removeClass('no_preview')
        $('.detido').addClass('yess_preview')
    } else {
        pending = false;
        $('.detido').addClass('no_preview')
        $('.detido').removeClass('yess_preview')
    }

    $('.showroom_garagem img').attr('src', dir + vehicle + '.png')

    velo_max.set(maxspeed)
    agilidade.set(agility)
    frenagem.set(braking)
    aderencia.set(aceleration)
    gasolina.set(gas)
    motor.set(engine)
    lataria.set(body)
}
var delay = false;
function setFavorite(vehicle) {
    if(isPublic == true){
        if (delay == false) {
            delay = true;
            let favorite = $('.' + vehicle).data('favorite')
            $.post("http://bm_module/setFavorite", JSON.stringify({
                vehicle: vehicle,
                favorite: favorite
            }));
    
            if (favorite == true) {
                $('.' + vehicle + ' .favorite_garagem').attr('src', 'garages/nui/images/favorite.svg')
                $('.' + vehicle).data("favorite", false);
            } else {
                $('.' + vehicle + ' .favorite_garagem').attr('src', 'garages/nui/images/yes_favorite.svg')
                $('.' + vehicle).data("favorite", true);
            }
            setTimeout(function () {
                delay = false;
            }, 1000)
        }

    }
}
function setMenu(page) {
    if (page == 'all') {
        $.post("http://bm_module/requestGarages", JSON.stringify({}), (data) => {
            let maxspeed = data.cars[0].maxspeed * 100 / 550 || 0
            let agility = data.cars[0].agility * 100 || 0
            let braking = data.cars[0].braking * 10 || 0
            let aceleration = data.cars[0].aceleration * 100 || 0
            let gas = data.cars[0].fuel || 0
            let engine = data.cars[0].engine || 0
            let body = data.cars[0].body || 0
            let ipva = data.cars[0].ipva || 0
            let detido = data.cars[0].status || 0

            if(data.isPublic == true) {
                isPublic = true
            }else{
                isPublic = false
            }

            if (data.cars[0].custom && data.cars[0].custom.mods) {
                custom.engine = data.cars[0].custom.mods[11]['mod'] ? true : false
                custom.breaking = data.cars[0].custom.mods[12]['mod'] ? true : false
                custom.transmission = data.cars[0].custom.mods[13]['mod'] ? true : false
                custom.suspension = data.cars[0].custom.mods[15]['mod'] ? true : false
                custom.shielding = data.cars[0].custom.mods[16]['mod'] ? true : false
                custom.turbo = data.cars[0].custom.mods[18]['mod'] ? true : false
            }

            if (custom.engine == true) {
                $('.custom_engine .progress_custom').addClass('yess_preview');
                $('.custom_engine .progress_custom').removeClass('no_preview');
                $('.custom_engine p').html('Ativado');
            } else {
                $('.custom_engine .progress_custom').addClass('no_preview');
                $('.custom_engine .progress_custom').removeClass('yess_preview');
                $('.custom_engine p').html('Desativado');
            }

            if (custom.breaking == true) {
                $('.custom_breaking .progress_custom').addClass('yess_preview');
                $('.custom_breaking .progress_custom').removeClass('no_preview');
                $('.custom_breaking p').html('Ativado');
            } else {
                $('.custom_breaking .progress_custom').addClass('no_preview');
                $('.custom_breaking .progress_custom').removeClass('yess_preview');
                $('.custom_breaking p').html('Desativado');
            }

            if (custom.transmission == true) {
                $('.custom_transmission .progress_custom').addClass('yess_preview');
                $('.custom_transmission .progress_custom').removeClass('no_preview');
                $('.custom_transmission p').html('Ativado');
            } else {
                $('.custom_transmission .progress_custom').addClass('no_preview');
                $('.custom_transmission .progress_custom').removeClass('yess_preview');
                $('.custom_transmission p').html('Desativado');
            }

            if (custom.suspension == true) {
                $('.custom_suspension .progress_custom').addClass('yess_preview');
                $('.custom_suspension .progress_custom').removeClass('no_preview');
                $('.custom_suspension p').html('Ativado');
            } else {
                $('.custom_suspension .progress_custom').addClass('no_preview');
                $('.custom_suspension .progress_custom').removeClass('yess_preview');
                $('.custom_suspension p').html('Desativado');
            }

            if (custom.shielding == true) {
                $('.custom_shielding .progress_custom').addClass('yess_preview');
                $('.custom_shielding .progress_custom').removeClass('no_preview');
                $('.custom_shielding p').html('Ativado');
            } else {
                $('.custom_shielding .progress_custom').addClass('no_preview');
                $('.custom_shielding .progress_custom').removeClass('yess_preview');
                $('.custom_shielding p').html('Desativado');
            }

            if (custom.turbo == true) {
                $('.custom_turbo .progress_custom').addClass('yess_preview');
                $('.custom_turbo p').html('Ativado');
                $('.custom_turbo .progress_custom').removeClass('no_preview');
            } else {
                $('.custom_turbo .progress_custom').addClass('no_preview');
                $('.custom_turbo .progress_custom').removeClass('yess_preview');
                $('.custom_turbo p').html('Desativado');
            }



            if (ipva == true) {
                pending = true;
                $('.ipva').removeClass('no_preview')
                $('.ipva').addClass('yess_preview')
            } else {
                pending = false;
                $('.ipva').addClass('no_preview')
                $('.ipva').removeClass('yess_preview')
            }

            if (detido == true) {
                pending = true;
                $('.detido').removeClass('no_preview')
                $('.detido').addClass('yess_preview')
            } else {
                pending = false;
                $('.detido').addClass('no_preview')
                $('.detido').removeClass('yess_preview')
            }

            velo_max.set(maxspeed)
            agilidade.set(agility)
            frenagem.set(braking)
            aderencia.set(aceleration)
            gasolina.set(gas)
            motor.set(engine)
            lataria.set(body)

            $('.showroom_garagem img').attr('src', 'http://131.196.198.118/carros/' + data.cars[0].vehicle + '.png')
            $('.right_garagem').html('');

            data.cars.map((item, index) => {
                $('.right_garagem').append(`
                    <div class="item_car_garagem ${item.vehicle}" data-tengine="${item.custom.mods && item.custom.mods[11] ? true : false}" data-tbreaking="${item.custom.mods && item.custom.mods[12] ? true : false}" data-ttransmission="${item.custom.mods && item.custom.mods[13] ? true : false}" data-tsuspension="${item.custom.mods && item.custom.mods[15] ? true : false}" data-tshielding="${item.custom.mods && item.custom.mods[16] ? true : false}" data-tturbo="${item.custom.mods && item.custom.mods[18] ? true : false}" data-maxspeed='${item.maxspeed}' data-ipva='${item.ipva}' data-detido='${item.status}' data-favorite='${item.favorite}'  data-agility='${item.agility}' data-braking='${item.braking}' data-aceleration='${item.aceleration}' data-fuel='${item.fuel}' data-engine='${item.engine}' data-body='${item.body}'
                        onclick="selectVehicle('${item.vehicle}', ${item.ipva}, ${item.status})" >
                        <div class="name_garagem">
                            ${item.vehicle.toUpperCase()}
                        </div>
                        <img class="favorite_garagem" src="garages/nui/images/favorite.svg" alt="" onclick="setFavorite('${item.vehicle}')">
                        <img class="img_car_garagem" src="${data.dir}${item.vehicle}.png"  onerror="this.src='garages/nui/images/default.png'"  alt="">
                    </div>
                `)
            })


            $('.' + data.cars[0].vehicle).addClass('item_car_select')

            for (let i = 0; i < data.cars.length; i++) {
                if (data.cars[i].favorite == true) {
                    $('.' + data.cars[i].vehicle + ' .favorite_garagem').attr('src', 'garages/nui/images/yes_favorite.svg')
                } else {
                    $('.' + data.cars[i].vehicle + ' .favorite_garagem').attr('src', 'garages/nui/images/favorite.svg')
                }
            }
        });
    }

    if (page == 'favorite') {
        $.post("http://bm_module/requestGarages", JSON.stringify({}), (data) => {
            let favorites = data.cars.filter(favorite => favorite.favorite == true);
            let maxspeed = data.cars[0].maxspeed * 100 / 550 || 0
            let agility = data.cars[0].agility * 100 || 0
            let braking = data.cars[0].braking * 10 || 0
            let aceleration = data.cars[0].aceleration * 100 || 0
            let gas = data.cars[0].fuel || 0
            let engine = data.cars[0].engine || 0
            let body = data.cars[0].body || 0

            let ipva = data.cars[0].ipva || 0
            let detido = data.cars[0].status || 0

            if(data.isPublic == true) {
                isPublic = true
            }else{
                isPublic = false
            }

            if (data.cars[0].custom && data.cars[0].custom.mods) {
                custom.engine = data.cars[0].custom.mods[11]['mod'] ? true : false
                custom.breaking = data.cars[0].custom.mods[12]['mod'] ? true : false
                custom.transmission = data.cars[0].custom.mods[13]['mod'] ? true : false
                custom.suspension = data.cars[0].custom.mods[15]['mod'] ? true : false
                custom.shielding = data.cars[0].custom.mods[16]['mod'] ? true : false
                custom.turbo = data.cars[0].custom.mods[18]['mod'] ? true : false
            }

            if (custom.engine == true) {
                $('.custom_engine .progress_custom').addClass('yess_preview');
                $('.custom_engine .progress_custom').removeClass('no_preview');
                $('.custom_engine p').html('Ativado');
            } else {
                $('.custom_engine .progress_custom').addClass('no_preview');
                $('.custom_engine .progress_custom').removeClass('yess_preview');
                $('.custom_engine p').html('Desativado');
            }

            if (custom.breaking == true) {
                $('.custom_breaking .progress_custom').addClass('yess_preview');
                $('.custom_breaking .progress_custom').removeClass('no_preview');
                $('.custom_breaking p').html('Ativado');
            } else {
                $('.custom_breaking .progress_custom').addClass('no_preview');
                $('.custom_breaking .progress_custom').removeClass('yess_preview');
                $('.custom_breaking p').html('Desativado');
            }

            if (custom.transmission == true) {
                $('.custom_transmission .progress_custom').addClass('yess_preview');
                $('.custom_transmission .progress_custom').removeClass('no_preview');
                $('.custom_transmission p').html('Ativado');
            } else {
                $('.custom_transmission .progress_custom').addClass('no_preview');
                $('.custom_transmission .progress_custom').removeClass('yess_preview');
                $('.custom_transmission p').html('Desativado');
            }

            if (custom.suspension == true) {
                $('.custom_suspension .progress_custom').addClass('yess_preview');
                $('.custom_suspension .progress_custom').removeClass('no_preview');
                $('.custom_suspension p').html('Ativado');
            } else {
                $('.custom_suspension .progress_custom').addClass('no_preview');
                $('.custom_suspension .progress_custom').removeClass('yess_preview');
                $('.custom_suspension p').html('Desativado');
            }

            if (custom.shielding == true) {
                $('.custom_shielding .progress_custom').addClass('yess_preview');
                $('.custom_shielding .progress_custom').removeClass('no_preview');
                $('.custom_shielding p').html('Ativado');
            } else {
                $('.custom_shielding .progress_custom').addClass('no_preview');
                $('.custom_shielding .progress_custom').removeClass('yess_preview');
                $('.custom_shielding p').html('Desativado');
            }

            if (custom.turbo == true) {
                $('.custom_turbo .progress_custom').addClass('yess_preview');
                $('.custom_turbo p').html('Ativado');
                $('.custom_turbo .progress_custom').removeClass('no_preview');
            } else {
                $('.custom_turbo .progress_custom').addClass('no_preview');
                $('.custom_turbo .progress_custom').removeClass('yess_preview');
                $('.custom_turbo p').html('Desativado');
            }


            if (ipva == true) {
                pending = true;
                $('.ipva').removeClass('no_preview')
                $('.ipva').addClass('yess_preview')
            } else {
                pending = false;
                $('.ipva').addClass('no_preview')
                $('.ipva').removeClass('yess_preview')
            }

            if (detido == true) {
                pending = true;
                $('.detido').removeClass('no_preview')
                $('.detido').addClass('yess_preview')
            } else {
                pending = false;
                $('.detido').addClass('no_preview')
                $('.detido').removeClass('yess_preview')
            }

            velo_max.set(maxspeed)
            agilidade.set(agility)
            frenagem.set(braking)
            aderencia.set(aceleration)
            gasolina.set(gas)
            motor.set(engine)
            lataria.set(body)

            $('.showroom_garagem img').attr('src', 'http://131.196.198.118/carros/' + data.cars[0].vehicle + '.png')
            $('.right_garagem').html('');

            data.cars.map((item, index) => {
                if (item.favorite == true) {
                    $('.right_garagem').append(`
                        <div class="item_car_garagem ${item.vehicle}" data-tengine="${item.custom.mods && item.custom.mods[11] ? true : false}" data-tbreaking="${item.custom.mods && item.custom.mods[12] ? true : false}" data-ttransmission="${item.custom.mods && item.custom.mods[13] ? true : false}" data-tsuspension="${item.custom.mods && item.custom.mods[15] ? true : false}" data-tshielding="${item.custom.mods && item.custom.mods[16] ? true : false}" data-tturbo="${item.custom.mods && item.custom.mods[18] ? true : false}" data-maxspeed='${item.maxspeed}' data-ipva='${item.ipva}' data-detido='${item.status}' data-favorite='${item.favorite}'  data-agility='${item.agility}' data-braking='${item.braking}' data-aceleration='${item.aceleration}' data-fuel='${item.fuel}' data-engine='${item.engine}' data-body='${item.body}'
                            onclick="selectVehicle('${item.vehicle}', ${item.ipva}, ${item.status})" >
                            <div class="name_garagem">
                                ${item.vehicle.toUpperCase()}
                            </div>
                            <img class="favorite_garagem" src="garages/nui/images/favorite.svg" alt="" onclick="setFavorite('${item.vehicle}')">
                            <img class="img_car_garagem" src="${data.dir}${item.vehicle}.png"  onerror="this.src='garages/nui/images/default.png'"  alt="">
                        </div>
                    `)
                }
            })

            $('.' + data.cars[0].vehicle).addClass('item_car_select')

            for (let i = 0; i < data.cars.length; i++) {
                if (data.cars[i].favorite == true) {
                    $('.' + data.cars[i].vehicle + ' .favorite_garagem').attr('src', 'garages/nui/images/yes_favorite.svg')
                } else {
                    $('.' + data.cars[i].vehicle + ' .favorite_garagem').attr('src', 'garages/nui/images/favorite.svg')
                }
            }
        });

    }
}

function guardar(proximity) {
    $.post("http://bm_module/storeCar", JSON.stringify({
        name: $('.item_car_select').data('name'),
        status: proximity
    }));
    $.post("http://bm_module/onClose", JSON.stringify({
        close: 'garages'
    }));
}
function retirar() {
    $.post("http://bm_module/spawnCar", JSON.stringify({
        name: $('.item_car_select').data('name'),
        pending: pending
    }));

    $.post("http://bm_module/onClose", JSON.stringify({
        close: 'garages'
    }));
}

$(".search_garagem").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $('.right_garagem .item_car_garagem').filter(function () {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    })
})