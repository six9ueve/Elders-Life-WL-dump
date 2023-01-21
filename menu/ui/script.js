$(document).ready(function () {
	// Mouse Controls
	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;
	var cursor = $('#cursorPointer');
	var cursorX = documentWidth / 2;
	var cursorY = documentHeight / 2;
	var idEnt = 0;
	var allowedWeapons = ["WEAPON_KNIFE" ,"WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", "WEAPON_SWITCHBLADE"]

	function UpdateCursorPos() {
		$('#cursorPointer').css('left', cursorX);
		$('#cursorPointer').css('top', cursorY);
	}

	/*function hasWeapon(){
		$.post('http://menu/hasWeapon', JSON.stringify({
			id: idEnt
		}));
	}*/
	function triggerClick(x, y) {
		var element = $(document.elementFromPoint(x, y));
		element.focus().click();
		return true;
	}

	// Listen for NUI Events
	window.addEventListener('message', function (event) {
		// Crosshair
		if (event.data.crosshair == true) {
			$(".crosshair").addClass('fadeIn');
			// $("#cursorPointer").css("display","block");
		}
		if (event.data.crosshair == false) {
			$(".crosshair").removeClass('fadeIn');
			// $("#cursorPointer").css("display","none");
		}
		//HasWeapon
		if (event.data.weapon == true) {
			$(".slashTires").addClass('fadeIn');
			// $("#cursorPointer").css("display","none");
		}
		//HasWeapon
		if (event.data.weapon == false) {
			$(".slashTires").removeClass('fadeIn');
			// $("#cursorPointer").css("display","none");
		}
		// Menu
		if (event.data.menu == 'vehicle') {
			$(".crosshair").addClass('active');
			$(".menu-car").addClass('fadeIn');
			idEnt = event.data.idEntity;
			// $("#cursorPointer").css("display","none");
		}
		if (event.data.menu == 'user') {
			
			$(".crosshair").addClass('active');
			$(".menu-user").addClass('fadeIn');
			idEnt = event.data.idEntity;
			// $("#cursorPointer").css("display","none");
		}
		if ((event.data.menu == false)) {
			$(".crosshair").removeClass('active');
			$(".menu").removeClass('fadeIn');
			idEnt = 0;
		}
		if (event.data.menu == 'coffee') {
			$(".crosshair").addClass('active');
			$(".menu-coffee").addClass('fadeIn');
			idEnt = event.data.idEntity;
			// $("#cursorPointer").css("display","none");
		}

		if (event.data.menu == 'water') {
			$(".crosshair").addClass('active');
			$(".menu-water").addClass('fadeIn');
			idEnt = event.data.idEntity;
			// $("#cursorPointer").css("display","none");
		}

		if (event.data.menu == 'trash') {
			$(".crosshair").addClass('active');
			$(".menu-trash").addClass('fadeIn');
			idEnt = event.data.idEntity;
			model = event.data.model
			// $("#cursorPointer").css("display","none");
		}

		if (event.data.menu == 'bank') {
			$(".crosshair").addClass('active');
			$(".menu-bank").addClass('fadeIn');
			idEnt = event.data.idEntity;
			// $("#cursorPointer").css("display","none");
		}

		if (event.data.menu == 'friandise') {
			$(".crosshair").addClass('active');
			$(".menu-friandise").addClass('fadeIn');
			idEnt = event.data.idEntity;
			// $("#cursorPointer").css("display","none");
		}


		if (event.data.menu == 'tv') {
			$(".crosshair").addClass('active');
			$(".menu-tv").addClass('fadeIn');
			idEnt = event.data.idEntity;
			// $("#cursorPointer").css("display","none");
		}

		if (event.data.menu == 'boisson') {
			$(".crosshair").addClass('active');
			$(".menu-boisson").addClass('fadeIn');
			idEnt = event.data.idEntity;
			// $("#cursorPointer").css("display","none");
		}

		// Click
		if (event.data.type == "click") {
			triggerClick(cursorX - 1, cursorY - 1);
		}
	});

	// Mousemove
	$(document).mousemove(function (event) {
		cursorX = event.pageX;
		cursorY = event.pageY;
		UpdateCursorPos();
	});

	// Click Menu

	// Functions
	// Vehicle
	$('.openCoffre').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/togglecoffre', JSON.stringify({
			id: idEnt
		}));
	});

	$('.openCapot').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/togglecapot', JSON.stringify({
			id: idEnt
		}));
		//$(this).find('.text').text($(this).find('.text').text() == 'Ouvrir le capot' ? 'Fermer le capot' : 'Ouvrir le capot');
     });
     
     $('.reparation').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/reparation', JSON.stringify({
			id: idEnt
		}));
	});

	$('.lock').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/lock', JSON.stringify({
			id: idEnt
		}));
		$(this).find('.text').text($(this).find('.text').text() == ' ' ? ' ' : ' ');
	});

	// Functions
	// User
	$('.cheer').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/cheer', JSON.stringify({
			id: idEnt
		}));
	});

	//Montrer sa carte à quelqu'un 
	//Thrylas
	$('.showIdCard').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/showIdCard', JSON.stringify({
			id: idEnt
		}));
	});
	//---------------------------------------
	//Montrer son permis à quelqu'un 
	//Thrylas
	$('.showDriverLicense').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/showDriverLicense', JSON.stringify({
			id: idEnt
		}));
	});
	//---------------------------------------
	//Ouvrir menu animation
	//Thrylas
	$('.toggleanim').on('click', function (e) {
		e.preventDefault();
		$(".menu-user").removeClass('fadeIn');
		$(".menu-anim").addClass('fadeIn');
	});
	//---------------------------------------
	//Ouvrir menu papier d'identité
	//Thrylas
	$('.togglepaper').on('click', function (e) {
		e.preventDefault();
		$(".menu-user").removeClass('fadeIn');
		$(".menu-paper").addClass('fadeIn');
	});
	//---------------------------------------
	//Montrer son certificat médical---------
	//Thrylas--------------------------------
	$('.showMedic').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/showMedic', JSON.stringify({
			id: idEnt
		}));
	});
	//---------------------------------------
	//Montrer son permis de port d'arme------
	//Thrylas--------------------------------
	$('.showFire').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/showFireArm', JSON.stringify({
			id: idEnt
		}));
	});
	//---------------------------------------
	//Lever les mains------------------------
	//Thrylas
	$('.shit').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/shit', JSON.stringify({
			id: idEnt
		}));
	});
	//---------------------------------------
	//Facturer-------------------------------
	//Thrylas
	$('.facture').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/facture', JSON.stringify({
			id: idEnt
		}));
	});
	//---------------------------------------
	//Verouiller/deverouiller le vehicule----
	//Thrylas
	$('.vehicleLock').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/vehicleLock', JSON.stringify({
			id: idEnt
		}));
	});
	//---------------------------------------
	//Crever les pneus-----------------------
	//Thrylas
	$('.slashTires').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/slashTires', JSON.stringify({
			id: idEnt
		}));
	});
	//---------------------------------------
	//Se cacher dans le coffre----------------
	//Thrylas
	$('.hideInTrunk').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/hideInTrunk', JSON.stringify({
			id: idEnt
		}));
	});
	
	//---------------------------------------
	//Machine à café----------------
	//Thrylas
	$('.coffee').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/coffee', JSON.stringify({
			id: idEnt
		}));
	});

	//---------------------------------------
	//Machine à eau----------------
	//Thrylas
	$('.water').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/water', JSON.stringify({
			id: idEnt
		}));
	});

	//---------------------------------------
	//Machine à eau----------------
	//Thrylas
	$('.trash').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/trash', JSON.stringify({
			id: idEnt,
			model: model
		}));
	});

	//---------------------------------------
	//Machine à friandise----------------
	//Thrylas
	$('.friandise').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/friandise', JSON.stringify({
			id: idEnt
		}));
	});

	//---------------------------------------
	//Machine à boisson----------------
	//Thrylas
	$('.boisson').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/boisson', JSON.stringify({
			id: idEnt
		}));
	});

	//---------------------------------------
	//Machine à boisson----------------
	//Thrylas
	$('.bank').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/bank', JSON.stringify({
			id: idEnt
		}));
	});
	
	$('.salue').on('click', function (e) {
		e.preventDefault();
		$.post('http://menu/salue', JSON.stringify({
			id: idEnt
		}));
	});


	// Click Crosshair
	$('.crosshair').on('click', function (e) {
		e.preventDefault();
		$(".crosshair").removeClass('fadeIn').removeClass('active');
		$(".menu").removeClass('fadeIn');
		$.post('http://menu/disablenuifocus', JSON.stringify({
			nuifocus: false
		}));
	});

	$(document).keypress(function (e) {
		if (e.which == 101) {
			$(".crosshair").removeClass('fadeIn').removeClass('active');
			$(".menu").removeClass('fadeIn');
			$.post('http://menu/disablenuifocus', JSON.stringify({
				nuifocus: false
			}));
		}
	});
});