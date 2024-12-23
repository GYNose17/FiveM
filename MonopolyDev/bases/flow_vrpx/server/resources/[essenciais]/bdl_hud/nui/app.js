$(document).ready(function(){
	window.addEventListener("message",function(event){
		if (event.data.hud == true){
			$(".allHud").show();
		}

		if (event.data.hud == false){
			$(".allHud").hide();
		}

		if (event.data.movie == true){
			$("#movieTop").css("display","block");
			$("#movieBottom").css("display","block");
		}

		if (event.data.movie == false){
			$("#movieTop").css("display","none");
			$("#movieBottom").css("display","none");
		}

		if (event.data.interact == true)  {
			$('#allScreen').fadeIn(200);
		}

		if (event.data.interact == false)  {
			$('#allScreen').fadeOut(200);
		}

		document.onkeyup = function(data){
			if (data.which == 27){
				$('#allScreen').fadeOut(200);
				$('body').removeClass("active");
				$.post('http://bdl_hud/hideFocus', JSON.stringify({}));
			}
		}

		var sliderWM = document.getElementById("watermarkslide");

		sliderWM.oninput = function() {
			if (sliderWM.value == 0) {
				$('#imgserver img').css("margin-left","8%")
			} else if (sliderWM.value == 1) {
				$('#imgserver img').css("margin-left","25%")
			} else if (sliderWM.value == 2) {
				$('#imgserver img').css("margin-left","50%")
			} else if (sliderWM.value == 3) {
				$('#imgserver img').css("margin-left","65%")
			} else if (sliderWM.value == 4) {
				$('#imgserver img').css("margin-left","92%")
			}
		}
		
		var sliderHUD = document.getElementById("allhudslide").value;
		var topInfo = document.getElementById('topInfoContainer');
		var bottomHUD = document.getElementById('hudBottomContainer');
		var isOnLeft = false;
		if (sliderHUD == 1) {
			topInfo.style.removeProperty('left');
			$('#topInfoContainer').css("right","20px");
			bottomHUD.style.removeProperty("left");
			$('#hudBottomContainer').css("right","20px");
			isOnLeft = false;
			
		} else if (sliderHUD == 0) {
			topInfo.style.removeProperty("right");
			$('#topInfoContainer').css("left","20px");
			bottomHUD.style.removeProperty("right");
			$('#hudBottomContainer').css("left","20px");
			isOnLeft = true;
		}
		

		let cineToggle = document.getElementById("cineMode");
		let hudToggle = document.getElementById("hideHUD");
		let markToggle = document.getElementById("hideMark");
		let statusToggle = document.getElementById("hideAllStatus");
		let infoToggle = document.getElementById("hideAllInfo");
		if (cineToggle.checked == true) {
			$("#movieTop").css("display","block");
			$("#movieBottom").css("display","block");
		} 
		if (hudToggle.checked == true) {
			$(".allHud").hide();
		} 
		if (markToggle.checked == true) {
			$("#imgserver").hide();
		} else {
			$("#imgserver").show();
		}
		if (statusToggle.checked == true) {
			$('#hudBottomContainer').css('display','none');
		} else {
			$('#hudBottomContainer').css('display','block');
		}
		if (infoToggle.checked == true) {
			$('#topInfoContainer').css('display','none');
		} else {
			$('#topInfoContainer').css('display','block');
		}
		

		$(".infosBack").html("<b>"+ event.data.day +"</b>, <b>"+ event.data.month +"  :</b>  "+ event.data.street);

		if (event.data.talking == true){
			$(".voiceDisplay1").css("background","rgba(255,255,255,0.9)");
			$(".voiceDisplay2").css("background","rgba(255,255,255,0.9)");
			$(".voiceDisplay3").css("background","rgba(255,255,255,0.9)");
		} else {
			$(".voiceDisplay1").css("background","rgba(255,255,255,0.3)");
			$(".voiceDisplay2").css("background","rgba(255,255,255,0.3)");
			$(".voiceDisplay3").css("background","rgba(255,255,255,0.3)");
		}

		if (event.data.voice == 1){
			$(".voiceDisplay1").css("display","none");
			$(".voiceDisplay1").css("margin-top","0");
			$(".voiceDisplay2").css("display","none");
			$(".voiceDisplay2").css("margin-top","0");
			$(".voiceDisplay3").css("display","block");
			$(".voiceDisplay3").css("margin-top","19px");
		}

		if (event.data.voice == 2){
			$(".voiceDisplay1").css("display","none");
			$(".voiceDisplay1").css("margin-top","0");
			$(".voiceDisplay2").css("display","block");
			$(".voiceDisplay2").css("margin-top","10px");
			$(".voiceDisplay3").css("display","block");
			$(".voiceDisplay3").css("margin-top","3px");
		}

		if (event.data.voice == 3){
			$(".voiceDisplay1").css("display","block");
			$(".voiceDisplay1").css("margin-top","1px");
			$(".voiceDisplay2").css("display","block");
			$(".voiceDisplay2").css("margin-top","3px");
			$(".voiceDisplay3").css("display","block");
			$(".voiceDisplay3").css("margin-top","3px");
		}

		if (event.data.health <= 1){
			$(".healthDisplay").css("width","0");
		} else {
			$(".healthDisplay").css("width",event.data.health +"%");
		}

		if (event.data.armour == 0){
			$(".armourBack").css("display","block");
			$(".armourDisplay").css("width",event.data.armour +"%");
		} else {
			$(".armourBack").css("display","block");
			$(".armourDisplay").css("width",event.data.armour +"%");
		}

		$(".thirstDisplay").css("height",100-event.data.thirst +"%");
		$(".hungerDisplay").css("height",100-event.data.hunger +"%");
		$(".staminaDisplay").css("width",100-event.data.stamina +"%");
		$(".clockBack .hudDisplayText").html(event.data.hour +":"+ event.data.minute);


	})
});