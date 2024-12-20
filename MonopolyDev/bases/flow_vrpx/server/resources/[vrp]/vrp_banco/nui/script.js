function addGaps(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
    }
    return x1 + x2;
}

function addCommas(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '.<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
    }
    return x1 + x2;
}

$(document).ready(function () {
    window.addEventListener('message', function (event) {
        var item = event.data;
        $('.welcome span').html(item.identidade);
        $('.card_name').html(item.identidade);

        if (item.openBank == true) {
            $("#container").fadeIn();
            $('.saldo span').html('$ ' + addCommas(item.bank));
        }

        if (item.updateBalance == true) {
            $('.saldo span').html('$ ' + addCommas(item.bank));
            $(".confirm").val('');
        }

        if (item.openBank == false) {
            $("#container").fadeOut();
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $("#container").fadeOut();
            $.post('http://vrp_banco/close', JSON.stringify({}));
        }
    };
});

var select = '';

function selectMenu(attr) {
    select = attr
    if (select == 'withdraw') {
        $('.select').removeClass('select')
        $('.' + attr).addClass('select')
        $('.passaport').fadeOut();
    } else if (select == 'deposit') {
        $('.select').removeClass('select')
        $('.' + attr).addClass('select')
        $('.passaport').fadeOut();

    } else if (select == 'transfer') {
        $('.select').removeClass('select')
        $('.' + attr).addClass('select')
        $('.passaport').fadeIn();

    } else if (select == 'payment') {
        $('.select').removeClass('select')
        $('.' + attr).addClass('select')
        $('.passaport').fadeOut();

    }
}

function submit() {
    if (select == 'withdraw') {
        console.log($(".value").val())
        $.post('http://vrp_banco/withdrawSubmit', JSON.stringify({
            amount: $(".value").val(),
        }));
    } else if (select == 'deposit') {
        $.post('http://vrp_banco/depositSubmit', JSON.stringify({
            amount: $(".value").val(),
        }));
    } else if (select == 'transfer') {
        $.post('http://vrp_banco/transferSubmit', JSON.stringify({
            amount: $(".value").val(),
            toPlayer: $(".id").val()
        }));
    } else if (select == 'payment') {
        $.post('http://vrp_banco/multasSubmit', JSON.stringify({
            amount: $(".value").val()
        }));
    }
}

$('.digital').click(() => {
    console.log("AQ NESSA BCT")
    $('path').addClass('teste').fadeIn();
    setTimeout(function () {
        $('.section_login').hide();
        $('.section_dash').fadeIn(500);
    }, 2000)
})