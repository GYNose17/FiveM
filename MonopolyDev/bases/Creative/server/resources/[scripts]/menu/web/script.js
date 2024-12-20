$(document).ready(function () {
    console.log();
    window.addEventListener("message", function (event) {
        switch (event.data.action) {
            case "Open":
                $(".Menu").html(`<img src="${event.data.payload}">`);
                $(".Menu").css("display", "block");
                break;

            case "Close":
                $("div").css("display", "none");
                break;
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("http://menu/Close");
        }
    };
});
