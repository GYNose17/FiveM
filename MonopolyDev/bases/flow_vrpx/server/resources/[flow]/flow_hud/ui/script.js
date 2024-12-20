 // Klaus JavaScript Deobfuscator 1.0
 var vehicle = [];
 var date = new Date();
 var d = date.getDate();
 var m = date.getMonth() + 1;
 var a = date.getFullYear();
 var assalt = false;
 var notifyNumber = 0;
 var chat = false;
 var messages = [];
 var dir = '';
 window.addEventListener('message', ({data: c}) => {
     if (c.action == 'hud') {
         if (c.plyInfos.active) {
             $('.info').fadeIn();
             $('.player').fadeIn();
         }
         if (!c.plyInfos.active) {
             $('.info').fadeOut();
             $('.velocimeter').fadeOut();
             $('.player').fadeOut();
         }
         setColors(c.cfgInfos.colors);
         dir = c.cfgInfos.dir;
         setVelocimeter(c.vehicle, c.vehInfos, c.plyInfos.active);
         setTalking(c.plyInfos.speaking);
         if (c.plyInfos.street) {
             setStreet(c.plyInfos.street);
         }
         setDirection(c.plyInfos.direction);
         setHour(c.plyInfos.hours + ':' + c.plyInfos.minutes);
         setVoice(c.plyInfos.voice);
         setRadio(c.plyInfos.radio || undefined);
         setLife(c.plyInfos.health);
         setArmour(c.plyInfos.armour);
         setDate();
         if (c.cfgInfos.cupom.active) {
             $('.cupom').fadeIn();
             setCupom(c.cfgInfos.cupom.name);
         } else {
             $('.cupom').fadeOut();
         }
         if (c.cfgInfos.assault.active) {
             setRobbery(c.plyInfos.hours, c.cfgInfos.assault);
         } else {
             $('.flexAssalt').fadeOut();
         }
         if (c.cfgInfos.hungerSystem.active == true) {
             $('.player .flex').fadeIn();
             $('.player .flex').css('display', 'flex');
             setHunger(c.plyInfos.hunger, c.plyInfos.thrist);
         }
     }
     if (c.action == 'ProgressBar') {
         setProgressBar(c.pgInfos.title, c.pgInfos.time, c.pgInfos.color);
     }
     if (c.action == 'NotifyAlert') {
         var e = c.ntfInfos;
         if (e.css != undefined || e.mensagem != undefined) {
             notifyAdm(e.title, e.mensagem, e.timer, notifyNumber, e.author, e.color);
         }
     }
     if (c.action == 'Notify') {
         var e = c.ntfInfos;
         if (e.css != undefined || e.mensagem != undefined) {
             setNotify(e.css, e.mensagem, e.timer, notifyNumber);
         }
     }
     if (c.action == 'chat') {
         setChat();
     }
     if (c.action == 'chatMessage') {
         setMessage(c.body.autor, c.body.color, c.body.text, false);
     }
     if (c.action == 'chatMessage:fstore') {
         setMessage(c.body.autor, c.body.color, c.body.text, true);
     }
     if (c.action == 'notifyItem') {
         setNotifyItem(c.ntfItem.mode, c.ntfItem.quantidade, c.ntfItem.nome, c.ntfItem.item);
     }
     if (c.type == 'chatMessage:template') {
         setMessage(null, null, c.template, true);
     }
 });
 var bottom = false;
 const setVelocimeter = (f, h, i) => {
     if (f) {
         if (bottom == false && i) {
             $('.player').animate({ left: '-=220px' }, 400);
             bottom = true;
             $('.velocimeter').fadeIn(500);
         }
         setDoors(h.doorstatus);
         setLights(h.lights);
         setEngine(h.engine);
         setFuel(h.fuel);
         setProgress(h.rpm);
         textKm(parseInt(h.speed));
         setSeat(h.seatbealt);
     }
     if (!f) {
         if (bottom == true) {
             $('.player').animate({ left: '+=220px' }, 400);
             $('.velocimeter').fadeOut(500);
             bottom = false;
         }
     }
 };
 const setSeat = j => {
     if (j == 1) {
         $('.seatbelt').hide();
     } else {
         $('.seatbelt').show();
     }
 };
 const setDoors = k => {
     removeDoors();
     if (k == false) {
         $('.doors').addClass('off_icon');
     }
     if (k == true) {
         $('.doors').addClass('on_icon');
     }
 };
 const setLights = l => {
     removeLight();
     if (l == 0) {
         $('.light').addClass('off_icon');
     }
     if (l == 1) {
         $('.light').addClass('middle_icon');
     }
     if (l == 2) {
         $('.light').addClass('on_icon');
     }
 };
 const setEngine = o => {
     removeEngine();
     if (o <= 30) {
         $('.engine').addClass('off_icon');
     }
     if (o <= 60) {
         $('.engine').addClass('middle_icon');
     }
     if (o >= 61) {
         $('.engine').addClass('on_icon');
     }
 };
 const textKm = q => {
     if (q <= 9) {
         $('.km .flex').html('<span class="opacity">0</span><span class="opacity">0</span><span>' + q + '</span>');
     }
     if (q >= 10 && q <= 99) {
         $('.km .flex').html('<span class="opacity">0</span><span>' + q + '</span>');
     }
     if (q >= 99) {
         $('.km .flex').html('<span>' + q + '</span>');
     }
 };
 const setLife = s => $('.life span').css('width', s + '%');
 const setArmour = t => $('.armour span').css('width', t + '%');
 const setRadio = u => {
     if (u >= 0 && u != undefined) {
         $('.radio p').html(u + 'mhz');
     } else {
         $('.radio p').html('OFF');
     }
 };
 const setTalking = v => {
     if (v) {
         $('.mic path').css('fill', '#4EFD5F');
     } else {
         $('.mic path').css('fill', '#fff');
     }
 };
 const setVoice = w => {
     removeVoice();
     if (w == 1) {
         $('.sussurando').addClass('on');
         $('.normal').addClass('off');
         $('.gritando').addClass('off');
     }
     if (w == 2) {
         $('.sussurando').addClass('on');
         $('.normal').addClass('on');
         $('.gritando').addClass('off');
     }
     if (w == 3) {
         $('.sussurando').addClass('on');
         $('.normal').addClass('on');
         $('.gritando').addClass('on');
     }
 };
 const setStreet = y => $('.street p').html('' + y);
 const setDirection = z => $('.street b').html('' + z);
 const setHour = aa => $('.date b').html(aa);
 const removeVoice = () => {
     $('.circle').removeClass('on');
     $('.circle').removeClass('off');
 };
 const removeLight = () => {
     $('.light').removeClass('on_icon');
     $('.light').removeClass('middle_icon');
     $('.light').removeClass('off_icon');
 };
 const removeDoors = () => {
     $('.doors').removeClass('on_icon');
     $('.doors').removeClass('middle_icon');
     $('.doors').removeClass('off_icon');
 };
 const removeEngine = () => {
     $('.engine').removeClass('on_icon');
     $('.engine').removeClass('middle_icon');
     $('.engine').removeClass('off_icon');
 };
 const setProgress = ab => {
     if (ab == 0) {
         setProgressSpeed(0, '.progress-speed');
     } else {
         if (ab <= 21) {
             setProgressSpeed(ab - 10, '.progress-speed');
         } else {
             setProgressSpeed(ab * 2.05, '.progress-speed');
         }
     }
 };
 const setFuel = ac => {
     $('.fuel span').css('height', ac + '%');
 };
 const setDate = () => {
     $('.date p').html(String(d).padStart(2, '0') + '/' + String(m).padStart(2, '0') + '/' + a);
 };
 const setProgressSpeed = (ad, ae) => {
     var af = document.querySelector(ae);
     var ag = af.r.baseVal.value;
     var ah = ag * 2 * Math.PI;
     var ai = ad * 100 / 220;
     af.style.strokeDasharray = ah + ' ' + ah;
     af.style.strokeDashoffset = '' + ah;
     const aj = ah - -ai * 73 / 100 / 100 * ah;
     af.style.strokeDashoffset = -aj;
 };
 var hours = [];
 const setRobbery = (ak, al) => {
     if (verifyAssalt(Number(ak), Number(al.hourInit), Number(al.hourFinish))) {
         $('.flexAssalt').fadeIn(500);
     } else {
         $('.flexAssalt').fadeOut(500);
     }
 };
 const setCupom = am => {
     $('.cupom b').html(am.toUpperCase());
 };
 const notifyAdm = (an, ao, ap, aq, ar, as) => {
     let at = '12px';
     if (ao.length >= 800) {
         at = '10px';
     } else {
         at = '12px';
     }
     var au = '\n        <div class="notify">\n            <div class="content_notify content_' + an.toLowerCase() + '" style="background: linear-gradient(100.41deg, ' + as.background + '21 -1.43%, ' + as.background + '80 100%); border: 1px solid ' + as.border + ';">\n                <div class="progressNotify progress_' + an.toLowerCase() + '  ' + aq + '"><span style="background: ' + as.background + ';"></span></div>\n                <div class="flex">\n                    <div class="icon icon_' + an.toLowerCase() + '" style="background: ' + as.background + ';">\n                        <img src="images/' + an.toLowerCase() + '.png" alt="">\n                    </div>\n                    <div class="texts">\n                        <div class="title_notify title_' + an.toLowerCase() + '" style="color: ' + as.title + ';">\n                            ' + an.toUpperCase() + ':\n                        </div>\n                        <div class="send_for" style="display: ' + (ar ? 'block' : 'none') + ';">Enviado por: <b>' + ar + '</b></div>\n                        <div class="text" style="font-size: ' + at + ';">\n                            ' + ao + '\n                        </div>\n                    </div>\n                </div>\n            </div>\n        </div>\n        ';
     $(au).fadeIn(500).appendTo('.notifysAdm').delay(ap).fadeOut(500);
     $('.' + aq + ' span').css('transition', 'height ' + ap + 'ms');
     setTimeout(() => {
         $('.' + aq + ' span').css('height', '0%');
         aq += 1;
     }, 100);
 };
 const setNotify = (av, aw, ax, ay) => {
     let az = '12px';
     if (aw.length >= 800) {
         az = '10px';
     } else {
         az = '12px';
     }
     var ba = '\n            <div class="notify">\n                <div class="content_notify content_' + av.toLowerCase() + '">\n                    <div class="progressNotify progress_' + av.toLowerCase() + '  ' + ay + '"><span></span></div>\n                    <div class="flex">\n                        <div class="icon icon_' + av.toLowerCase() + '">\n                            <img src="images/' + av.toLowerCase() + '.png" alt="">\n                        </div>\n                        <div class="texts">\n                            <div class="title_notify title_' + av.toLowerCase() + '">\n                                ' + av.toUpperCase() + '\n                            </div>\n                            <div class="text" style="font-size: ' + az + ';">\n                                ' + aw + '\n                            </div>\n                        </div>\n                    </div>\n                </div>\n            </div>\n        ';
     $(ba).fadeIn(500).appendTo('.notifys').delay(ax).fadeOut(500);
     $('.' + ay + ' span').css('transition', 'height ' + ax + 'ms');
     setTimeout(() => {
         $('.' + ay + ' span').css('height', '0%');
         ay += 1;
     }, 100);
 };
 const setNotifyItem = (bb, bc, bd, be) => {
     var bf = '\n            <div class="notifyItem content_' + bb + '">\n                <div class="icon icon_' + bb + '"><img src="images/' + bb + '.png" alt=""></div>\n                <img src="' + dir + '/' + be + '.png" alt="" class="imgItem">\n                <div class="qtd_notifyItem">' + bc + 'x</div>\n                <div class="name_notifyItem">' + bd + '</div>\n            </div>\n        ';
     $(bf).fadeIn(500).appendTo('.notifysItens').delay(5000).fadeOut(500);
     setTimeout(() => {
         notifyNumber += 1;
     }, 100);
 };
 const setProgressBar = (bh, bi, bj) => {
     $('.progressbar').fadeIn();
     $('.progress_progress span').css('transition', 'width ' + bi + 'ms');
     $('.top_progress p').html('\n        ' + convertTime(bi) + ' <img src="images/progress.png" alt="">\n    ');
     $('.notifysItens').css('bottom', '95px');
     $('.progress_progress').css('background', 'linear-gradient(100.41deg, ' + bj.background + '21 -1.43%, ' + bj.background + '80 100%)');
     $('.progress_progress').css('border', ' 1px solid ' + bj.border);
     $('.progress_progress .space span').css('background', 'linear-gradient(100.41deg, ' + bj.background + ' -1.43%, ' + bj.background + ' 100%)');
     const bk = setInterval(() => {
         $('.top_progress p').html('\n            ' + convertTime(bi) + ' <img src="images/progress.png" alt="">\n        ');
         bi = bi - 1000;
         if (bi <= 0) {
             clearInterval(bk);
             $('.progress_progress span').css('width', '0%');
         }
     }, 1000);
     setTimeout(() => {
         $('.progress_progress span').css('width', '100%');
     }, 1);
     setTimeout(() => {
         $('.progressbar').fadeOut();
         $('.notifysItens').css('bottom', '20px');
     }, bi);
 };
 const setHunger = (bl, bm) => {
     $('.hunger span').css('width', bl + '%');
     $('.thrist span').css('width', bm + '%');
 };
 function convertTime(bn) {
     var bo = Math.floor(bn / 60000);
     var bp = (bn % 60000 / 1000).toFixed(0);
     return (bo < 10 ? '0' : '') + bo + ':' + (bp < 10 ? '0' : '') + bp;
 }
 const setChat = () => {
     chat = true;
     $('.list_messages').css('opacity', '1');
     $('.submit_message').css('opacity', '1');
     document.getElementById('input').focus();
 };
 $('#input').on('keydown', function (bq) {
     if (bq.key === 'Enter' || bq.keyCode === 13) {
         bq.preventDefault();
     }
 });
 $('body').on('keydown', function (br) {
     if (br.key == 'Escape' && chat == true) {
         $.post('http://flow_hud/closeChat', JSON.stringify({}));
         $('.list_messages').css('opacity', '0');
         $('.submit_message').css('opacity', '0');
     }
 });
 var inMessage = 1;
 $('#input').on('keyup', function (bs) {
     if (bs.key === 'Enter' || bs.keyCode === 13) {
         $('.submit_message').css('opacity', '0');
         if ($('#input').val().startsWith('/')) {
             $.post('http://flow_hud/flow_hud:recieveMessage', JSON.stringify({
                 message: $('#input').val().replace('/', ''),
                 command: true
             }));
             chat = false;
         } else {
             $.post('http://flow_hud/flow_hud:recieveMessage', JSON.stringify({
                 message: $('#input').val(),
                 command: false
             }));
             chat = false;
         }
         if (messages.length <= 9) {
             messages.push($('#input').val());
         }
         if (messages.length >= 10) {
             messages.pop();
             messages.unshift($('#input').val());
         }
         $('#input').val('');
         inMessage = messages.length;
     }
     if (bs.key == 'ArrowUp' || bs.key == 38) {
         if (inMessage >= 1) {
             inMessage--;
             $('#input').val(messages[inMessage]);
         }
     }
     if (bs.key == 'ArrowDown' || bs.key == 40) {
         if (inMessage < messages.length) {
             $('#input').val(messages[inMessage]);
             inMessage++;
         }
     }
 });
 const setMessage = (bt, bu, bv, bw) => {
     if (!bw) {
         bv = '<span>' + bv.replace(/\^([0-9])/g, (bx, by) => '</span><span class="color-' + by + '">') + '</span>';
         $('.list_messages').append('\n            <div class="item_chat" style="background: linear-gradient(100.41deg,rgba(' + bu + ', 0.051) -1.43%, rgba(' + bu + ', 0.102) 100%), linear-gradient(100.99deg, rgba(' + bu + ', 0.2) 7.92%, rgba(' + bu + ', 0.165) 102.79%)">\n                <div class="author_chat">\n                    ' + bt + ' \n                </div>\n                <div class="message">\n                    ' + bv + '\n                </div>\n            </div>\n        ');
     }
     if (bw) {
         bv.html.template = '<span>' + bv.html.template.replace(/\^([0-9])/g, (bz, ca) => '</span><span class="color-' + ca + '">') + '</span>';
         $('.list_messages').append('\n            <div class="item_chat fstore">\n                <div class="message">\n                    ' + bv.html.template + '\n                </div>\n            </div>\n            \n        ');
     }
     $('.list_messages').css('opacity', '1');
     let cb = setInterval(() => {
         if (!chat) {
             $('.list_messages').css('opacity', '0');
             $('.submit_message').css('opacity', '0');
             clearInterval(cb);
         }
     }, 5000);
     var cc = document.getElementsByClassName('list_messages')[0];
     cc.scrollTop = cc.scrollTop + 100;
 };
 const setColors = cd => {
     document.body.style.setProperty('--primary-bg-color', cd.primaryBgColor);
     document.body.style.setProperty('--secondary-bg-color', cd.secundaryBgColor);
     document.body.style.setProperty('--primary-icon-color', cd.primaryIconColor);
     document.body.style.setProperty('--secondary-icon-color', cd.secondaryIconColor);
     document.body.style.setProperty('--border-color', cd.borderColor);
     document.body.style.setProperty('--title-color', cd.titleColor);
     document.body.style.setProperty('--subtitle-color', cd.subtitleColor);
 };
 const verifyAssalt = (ce, cf, cg) => {
     let ch = false;
     if (cf > 9 && cg < 10) {
         if (ce < 10) {
             ce += 24;
         }
         ch = between(ce, cf, cg + 24);
     } else {
         ch = between(ce, cf, cg);
     }
     assalt = ch;
     return ch;
 };
 function between(ci, cj, ck) {
     return ci >= cj && ci <= ck;
 }