$(function () {
    window.addEventListener("message", function (event) {
        var item = event.data
        if (item.setDisplay) {
            $("#container").fadeIn(200);
        } else {
            $("#container").fadeOut(200);
        }
    });
})