const Hub = {
    requestsCount: 0,
    notificationsCount: 0,
    muted: false,
    toggle: function(open) {
        if(open)
            $("#hub-tray, #hub").addClass("open");
        else
            $("#hub-tray, #hub").removeClass("open");
    },
    toggleMuted: function() {
        if(Hub.muted) {
            Hub.muted = false;
            $("#hub-mute span").html("silenciar");
        } else {
            Hub.muted = true;
            $("#hub-mute span").html("ouvir");
        }
    },
    addTemporaryNotification: function(type, title, description, persistent) {
        let temporaryId = Date.now();
        let persistentClass = "";
        console.log(type)

        if(persistent)
            persistentClass = " will-be-persistent";

        let elementTemporary = `<div class="hub-notification${persistentClass}" id="notification-${temporaryId}" hidden>
                                    <div class="hub-notification-content">
                                        <div class="hub-notification-title"><div class="hub-notification-icon"></div> ${title}</div>
                                        <div class="hub-notification-text">${description}</div>
                                    </div>
                                </div>`;
        
        $("#hub-tray").prepend(elementTemporary);
        $("#notification-" + temporaryId).fadeIn(200, function() {
            setTimeout(function() {
                $("#notification-" + temporaryId).fadeOut(200, function() {
                    $("#notification-" + temporaryId).remove();
                });
            }, 10000);
        });

        Hub.playAudio();
    },
    addNotification: function(type, title, description, persistent) {
        Hub.addTemporaryNotification(type, title, description, persistent);

        if(persistent) {
            let date = Hub.getDate();
            console.log(type)

            let elementPersistent = `<div class="hub-notification">
                            <div class="hub-notification-content">
                                <div class="hub-notification-title"><div class="hub-notification-icon"></div> ${title}</div>
                                <div class="hub-notification-text">
                                    ${description}
                                    <div class="hub-notification-timestamp">${date}</div>
                                </div>
                            </div>
                            <div class="hub-notification-options options-1">
                                <div class="hub-notification-option-remove" onclick="Hub.removeNotification(this)"></div>
                            </div>
                        </div>`;

            $("#hub-empty").fadeOut();
            if(Hub.notificationsCount == 0) {
                if(Hub.requestsCount > 0)
                    $("#hub").removeClass("lists-1").addClass("lists-2");

                $("[notification-type='regular']").fadeIn();
            }

            $(".hub-notifications[notification-type='regular']").prepend(elementPersistent);
            Hub.notificationsCount++;
        }
    },
    removeNotification: function(element) {
        $(element).parent().parent().fadeOut(200, function() {
            $(element).parent().parent().remove();
        });

        Hub.notificationsCount--;

        if(Hub.notificationsCount == 0) {
            $("[notification-type='regular']").fadeOut(200, function() {
                $("#hub").removeClass("lists-2").addClass("lists-1");
            });

            if(Hub.requestsCount == 0)
                $("#hub-empty").fadeIn();
        }                    
    },
    clearNotifications: function() {
        $("div[notification-type='regular'] .hub-notification .hub-notification-options .hub-notification-option-remove").each(function(index, element) {
            Hub.removeNotification(element);
        })
    },
    addRequest: function(type, title, description, id) {
        Hub.addTemporaryNotification(type, title, description, true);
        console.log(type)
        let date = Hub.getDate();
        let element = `<div class="hub-notification" request-id="${id}">
                            <div class="hub-notification-content">
                                <div class="hub-notification-title"><div class="hub-notification-icon"></div> ${title}</div>
                                <div class="hub-notification-text">
                                    ${description}
                                    <div class="hub-notification-timestamp">${date}</div>
                                </div>
                            </div>
                            <div class="hub-notification-options options-2">
                                <div class="hub-notification-option-accept" onclick="Hub.tryAcceptRequest(this)"></div>
                                <div class="hub-notification-option-remove" onclick="Hub.denyRequest(this)"></div>
                            </div>
                        </div>`;
        
        $("#hub-empty").fadeOut();
        if(Hub.requestsCount == 0) {
            if(Hub.notificationsCount > 0)
                $("#hub").removeClass("lists-1").addClass("lists-2");

            $("[notification-type='request']").fadeIn();
        }

        $(".hub-notifications[notification-type='request']").prepend(element);
        Hub.requestsCount++;
    },
    tryAcceptRequest: function(element) {
        if($(element).parent().parent().hasClass("hub-notification-accepted"))
            return false;

        let requestId = $(element).parent().parent().attr("request-id");

        $.post("http://alerts/tryAcceptRequest", JSON.stringify({id: requestId}));
    },
    denyRequest: function(element) {
        $(element).parent().parent().fadeOut(200, function() {
            $(element).parent().parent().remove();
        });

        Hub.requestsCount--;

        if(Hub.requestsCount == 0) {
            $("[notification-type='request']").fadeOut(200, function() {
                $("#hub").removeClass("lists-2").addClass("lists-1");
            });

            if(Hub.notificationsCount == 0)
                $("#hub-empty").fadeIn();
        }
    },
    setAcceptedRequest: function(requestId, playerId) {
        if(playerId == "ok") {
            $(".hub-notification[request-id='" + requestId + "']").addClass("hub-notification-accepted")
            .children(".hub-notification-options").removeClass("options-2").addClass("options-1").children(".hub-notification-option-accept").remove();
        } else {
            $(".hub-notification[request-id='" + requestId + "']").children(".hub-notification-options").children(".hub-notification-option-accept")
            .addClass("hub-notification-option-accepted").removeClass("hub-notification-option-accept").html("Atendido por " + playerId);

            setTimeout(function() {
                $(".hub-notification[request-id='" + requestId + "']")
                .children(".hub-notification-options").children(".hub-notification-option-remove").trigger("click");
            }, 10000);
        }
    },
    playAudio: function() {
        if(!Hub.muted)
            $("#hub-audio")[0].play();
    },
    getDate: function() {
        let date = new Date();
        return (date.getHours() > 9 ? date.getHours() : "0" + date.getHours()) + ":" + (date.getMinutes() > 9 ? date.getMinutes() : "0" + date.getMinutes()) + " " + (date.getDate() > 9 ? date.getDate() : "0" + date.getDate()) + "/" + (date.getMonth() > 9 ? date.getMonth() : "0" + date.getMonth())
    }
};

window.addEventListener('message', function(event) {
    let received = event.data;

    switch(received.action) {
        case 'open':
            Hub.toggle(true);
            break;
        case 'addNotification':
            Hub.addNotification(received.type, received.title, received.description, received.persistent);
            break;
        case 'addRequest':
            Hub.addRequest(received.type, received.title, received.description, received.id);
            break;
        case 'setAcceptedRequest':
            Hub.setAcceptedRequest(received.id, received.user_id);
            break;
    }
});

window.onkeyup = function(data) {
    if (data.which == 27) {
        Hub.toggle(false);
        $.post("http://alerts/close", JSON.stringify({}));
    } else if(data.which == 9) {
        Hub.toggleMuted();
    }
};