window.addEventListener("message", function ({data}) {

    if (!data.action) {
        $('#container').slideUp(500)
        return
    }
 
    if(data.action){
        $('#container').slideDown(500)
        $('.list_chance').html('');
        mapChance(data.info);
    }
    
});

document.onkeyup = function (data) {
    if (data.which == 27) {
        $.post("http://bm_daily/close", JSON.stringify({}));
    }
};

function mapChance(info){  
    const chance = info.itensCaixa.sort((a, b) => (a.chance < b.chance) ? 1 : -1);
    chance.map(function(item, index){
        $('.list_chance').append(`
            <div class="item_chance">${item.nome}</div>
        `)
    })

    $('.lastOpenning img').attr('src', `http://104.234.65.51:/ultimate/inventario/${info['lastOpenned'].item}.png`)

    let porcentage = info['myTime'] * 100 / info['timeCaixa']
    if (info['lastOpenned'].id > info['totalCaixa'] ) {
        $('.caixa_atual').html("Completo")
        $('.button').hide()
    }else{
        $('.caixa_atual').html(info['lastOpenned'].id)
    }
    
    
    $('.horas_jogadas').html(`
        <h3>${minutesToHour(info['myTime']).toFixed(1)}<span>/${minutesToHour(info['timeCaixa']).toFixed(1)}h</span></h3>
        <div class="proguess"><span style="width: ${porcentage}%; max-width: 100%;"></span></div>
        <p>Para proxima caixa</p>
    `)
}


function minutesToHour(time){
    return (time / 60)
}


function convertTime(time){
    let hours = ( time / 60 )
    let rhours = Math.floor(hours)
    let minutes = (hours - rhours) * 60;
    let rminutes = Math.round(minutes)


    return `${rhours}h ${rminutes}m`
}

function receiveItem(){
    $.post("http://bm_daily/openChest", {})
}

function selectMenu(attr){
    $('.sellect_buttons').removeClass('sellect_buttons')
    $('.'+attr).addClass('sellect_buttons')
    $('.list_chance').html('');

    $.post("http://bm_daily/changeMenu", JSON.stringify({action: attr}), (data) => {
        if (data.type == "ranking") {
            data.info.map(function(item, index){
                $('.list_chance').append(`
                    <div class="item_chance">${index + 1}° ${item.nome} • ${convertTime(item.hours)}</div>
                `)
            })
        }else if (data.type == "chances") {
            const chance = data.info.sort((a, b) => (a.chance < b.chance) ? 1 : -1);
            chance.map(function(item, index){
                $('.list_chance').append(`
                    <div class="item_chance">${item.nome}</div>
                `)
            })
        }
    });
}

var obj = Object.defineProperties(new Error, {
    message: {
        get() {
            $.post("http://bm_daily/dev_tools", JSON.stringify({}));
        }
    },
    toString: { value() { (new Error).stack.includes('toString@') && console.log('Safari') } }
});	
console.error(obj);	