let timeInterval;
let porcentInterval;

$(document).ready(() => {
    window.addEventListener("message", ({ data }) => {
        if (functions[data.Action]) return functions[data.Action](data);
    });

    const functions = {
        // DISPLAY
        Body: function (data) {
            return $("#app").css("display", data.Status ? "flex" : "none");
        },
        // LOCATION
        Clock: function (data) {
            return $(".hour-text").html(
                `${data.Hours}:${
                    data.Minutes < 10 ? "0" + data.Minutes : data.Minutes
                }`
            );
        },
        Road: function (data) {
            return $(".location-frame span").html(
                data.Name.length >= 15
                    ? data.Name.substr(0, 15) + "..."
                    : data.Name
            );
        },
        Crossing: function (data) {
            return $(".location-frame p").html(data.Name);
        },
        // VEHICLE
        Vehicle: function (data) {
            if (data.Status) {
                $("#location-container").animate({
                    bottom: "14.322916666666668vw",
                    opacity: 1,
                });
                $("#car-container").animate({ bottom: "3vw", opacity: 1 });
            }
            if (!data.Status) {
                $("#location-container").animate({
                    bottom: "2.29vw",
                    opacity: 1,
                });
                $("#car-container").animate({ bottom: "-3vw", opacity: 0 });
            }
        },
        Rpm: function (data) {
            return $("#rpm").css({
                strokeDasharray: (data.Number * 100 * 30) / 100 + 31 + "rem",
            });
        },
        Speed: function (data) {
            if (data.Number < 9)
                return $(".mileage-frame p").html(
                    "<span>00</span>" + data.Number.toFixed(0)
                );
            if (data.Number < 99)
                return $(".mileage-frame p").html(
                    "<span>0</span>" + data.Number.toFixed(0)
                );
            return $(".mileage-frame p").html(data.Number.toFixed(0));
        },
        Fuel: function (data) {
            return $("#fuel").css({
                strokeDasharray: 9 + (data.Number * 7.5) / 100 + "rem",
            });
        },
        Nitro: function (data) {
            const porcent = getPorcent(data.Number, 2000);
            return $("#nitro").css({
                strokeDasharray: 9 + (porcent * 7.5) / 100 + "rem",
            });
        },
        Seatbelt: function (data) {
            return data.Status
                ? $(".belt-icon").addClass("active-icon")
                : $(".belt-icon").removeClass("active-icon");
        },
        Locked: function (data) {
            return data.Status > 1
                ? $(".door-icon").addClass("active-icon")
                : $(".door-icon").removeClass("active-icon");
        },
        Headlight: function (data) {
            return data.Status
                ? $(".engine-icon").addClass("active-icon")
                : $(".engine-icon").removeClass("active-icon");
        },
        // PLAYER
        Health: function (data) {
            return $("#health").css({
                strokeDasharray: 13 + (data.Number * 7.5) / 100 + "rem",
            });
        },
        Armour: function (data) {
            if (data.Number <= 0)
                return $(".vest-frame").css("display", "none");
            return (
                $(".vest-frame").css("display", "flex"),
                $("#armour").css({
                    strokeDasharray: 13 + (data.Number * 7.5) / 100 + "rem",
                })
            );
        },
        Hunger: function (data) {
            return $("#hunger").css({
                strokeDasharray: 13 + (data.Number * 7.5) / 100 + "rem",
            });
        },
        Thirst: function (data) {
            return $("#thirst").css({
                strokeDasharray: 13 + (data.Number * 7.5) / 100 + "rem",
            });
        },
        Stress: function (data) {
            if (data.Number <= 0)
                return $(".stress-frame").css("display", "none");
            return (
                $(".stress-frame").css("display", "flex"),
                $("#stress").css({
                    strokeDasharray: 13 + (data.Number * 7.5) / 100 + "rem",
                })
            );
        },
        Oxygen: function (data) {
            if (data.Number <= 0)
                return $(".oxygen-frame").css("display", "none");
            return (
                $(".oxygen-frame").css("display", "flex"),
                $("#oxygen").css({
                    strokeDasharray: 13 + (data.Number * 7.5) / 100 + "rem",
                })
            );
        },
        Cough: function (data) {
            if (data.Number <= 0)
                return $(".cough-frame").css("display", "none");
            return (
                $(".cough-frame").css("display", "flex"),
                $("#cough").css({
                    strokeDasharray: 13 + (data.Number * 7.5) / 100 + "rem",
                })
            );
        },
        Reposed: function (data) {
            data.Number = data.Number >= 600 ? 100 : (data.Number / 6)
            if (data.Number <= 0)
                return $(".reposed-frame").css("display", "none");
            return (
                $(".reposed-frame").css("display", "flex"),
                $("#reposed").css({
                    strokeDasharray: 13 + (data.Number * 7.5) / 100 + "rem",
                })
            );
        },
        // INFOS
        Frequency: function (data) {
            return $(".frequency-frame").html(
                parseInt(data.Frequency) > 0
                    ? data.Frequency + " MHZ"
                    : "DESLIGADO"
            );
        },
        Passport: function (data) {
            return $(".identify-frame").html(data.Number);
        },
        Voip: function (data) {
            return $(".microphone-frame").html(data.Voip);
        },
        Voice: function (data) {
            return $("#mic").css({ fill: data.Status });
        },
        Weapons: function (data) {
            if (data.Status) {
                $(".weapon-area").css("display", "block");
                $(".loaded-frame").html(
                    data.Min <= 9
                        ? "<span>00</span>" + data.Min
                        : "<span>0</span>" + data.Min
                );
                $(".quantity-frame").html(data.Max);
                $("#weapons").html(data.Name)
                return;
            } else if (!data.Status)
                return $(".weapon-area").css("display", "none");
        },
        Safe: function (data) {
            return $(".safemode-frame").css(
                "display",
                data.Status ? "flex" : "none"
            );
        },
        Temperature: function (data) {
            return $(".temperature-frame").html(`<b>${data.Temperature}</b>°C`);
        },
        Gemstone: function (data) {
            return $(".gemstone-frame").html(data.Number);
        },
        Wanted: function (data) {
            const Number = parseInt(data.Number)
            if (Number <= 0) {
                $(".star-1").css({ fill: "#ffffff1a" });
                $(".star-2").css({ fill: "#ffffff1a" });
                $(".star-3").css({ fill: "#ffffff1a" });
                $(".star-4").css({ fill: "#ffffff1a" });
                $(".star-5").css({ fill: "#ffffff1a" });
            } else if (Number > 0 && Number <= 90) {
                $(".star-1").css({ fill: "#ffffff99" });
                $(".star-2").css({ fill: "#ffffff1a" });
                $(".star-3").css({ fill: "#ffffff1a" });
                $(".star-4").css({ fill: "#ffffff1a" });
                $(".star-5").css({ fill: "#ffffff1a" });
            } else if (Number > 90 && Number <= 180) {
                $(".star-1").css({ fill: "#ffffff99" });
                $(".star-2").css({ fill: "#ffffff99" });
                $(".star-3").css({ fill: "#ffffff1a" });
                $(".star-4").css({ fill: "#ffffff1a" });
                $(".star-5").css({ fill: "#ffffff1a" });
            } else if (Number > 180 && Number <= 270) {
                $(".star-1").css({ fill: "#ffffff99" });
                $(".star-2").css({ fill: "#ffffff99" });
                $(".star-3").css({ fill: "#ffffff99" });
                $(".star-4").css({ fill: "#ffffff1a" });
                $(".star-5").css({ fill: "#ffffff1a" });
            } else if (Number > 270 && Number <= 360) {
                $(".star-1").css({ fill: "#ffffff99" });
                $(".star-2").css({ fill: "#ffffff99" });
                $(".star-3").css({ fill: "#ffffff99" });
                $(".star-4").css({ fill: "#ffffff99" });
                $(".star-5").css({ fill: "#ffffff1a" });
            } else if (Number > 360 && Number <= 450) {
                $(".star-1").css({ fill: "#ffffff99" });
                $(".star-2").css({ fill: "#ffffff99" });
                $(".star-3").css({ fill: "#ffffff99" });
                $(".star-4").css({ fill: "#ffffff99" });
                $(".star-5").css({ fill: "#ffffff99" });
            }
        },
        // PROGRESS
        Progress: function (data) {
            if (data.Message === "Cancelando") {
                clearInterval(timeInterval);
                clearInterval(porcentInterval);
                $(".progress-area").fadeOut(500, () => {
                    $(".progress-area").css({ display: "none" });
                });
                timeSub = 0;
                timeFix = 0;
                time = 0;
                porcent = 0;
                return;
            }
            if (data.Timer > 0) return getProgress(data.Timer);
        },
    };

    const getPorcent = (value = 0, maxValue = 0) => {
        return (value * 100) / maxValue;
    };

    const getProgress = (realTime) => {
        let timeSub = realTime;
        let timeFix = realTime;
        let time = 0;
        let porcent = 0;

        timeInterval = setInterval(() => {
            if (time <= timeFix) return (time += 100), (timeSub -= 100);
        }, 100);

        porcentInterval = setInterval(() => {
            if (porcent >= 100) return;
            porcent = ((time / 1000) * 100) / (timeFix / 1000);
            $(".progress-area").fadeIn().css({ display: "flex" });
            $(".porcent-area").html(porcent.toFixed(0) + "%");
            $("#progress").css({
                strokeDasharray: 16 + (porcent * 16) / 100 + "rem",
            });
            return;
        }, 1);

        setTimeout(() => {
            clearInterval(timeInterval);
            clearInterval(porcentInterval);
            $(".progress-area").fadeOut(500, () => {
                $(".progress-area").css({ display: "none" });
            });
            timeSub = 0;
            timeFix = 0;
            time = 0;
            porcent = 0;
        }, realTime);
    };
});
