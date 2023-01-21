$('document').ready(function(){
	let audio = null

	function playAudio(audioSrc){
		if (audio!=null){
			audio.stop()
		}
		audio = new Howl({src:[audioSrc]})
		audio.volume(0.3)
		audio.play()
	}

	function intro() {
		$('img').attr("src", "./vid/fingerprint_intro.gif")
		playAudio('./audio/intro.mp3')
		setTimeout(function() {
			$('img').attr('src', "")
			audio.stop()
		}, 3000)
	}
	
	function success() {
		$('img').attr("src", "./vid/fingerprint_success.gif")
		playAudio('./audio/outro.mp3')
		setTimeout(function() {
			$('img').attr('src', "")
		}, 3000)
	}
	
	function fail() {
		$('img').attr("src", "./vid/fingerprint_fail.gif")
		playAudio('./audio/outro.mp3')
		setTimeout(function() {
			$('img').attr('src', "")
		}, 3000)
	}

	function upDown(kepress){
		if(kepress == "up"){
			playAudio('./audio/up.mp3')
		}
		else{
			playAudio('./audio/down.mp3')
		}
	}

	function leftRight(kepress){
		if(kepress == "left"){
			playAudio('./audio/left.mp3')
		}
		else{
			playAudio('./audio/right.mp3')
		}
	}

	function dialog(){
		playAudio('./audio/dialogFlash.mp3')
	}

	function processing(){
		playAudio('./audio/processing.mp3')
	}
  
	window.addEventListener("message", (event) => {
		let type = event.data.type
		if (type == "intro"){
			intro()
		} 
		
		else if (type == "success"){
			success()
		}
		
		else if (type == "fail"){
			fail()
		}

		else if (type == "audio") {
			if (event.data.audioType == "verticalMove"){
				upDown(event.data.keypress)
			}
			else if (event.data.audioType == "horizontalMove"){
				leftRight(event.data.keypress)
			}
			else if (event.data.audioType == "dialog"){
				dialog()
			}
			else if (event.data.audioType == "processing"){
				processing()
			}
		}
	})
  
})
  
  