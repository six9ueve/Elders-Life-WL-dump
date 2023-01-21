$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});

let scriptName = ""

window.addEventListener('message', function(event) {
    scriptName = event.data.scriptName
    if (event.data.enable) {
        $("#radio").animate({bottom: "0"},500)
    } else {
        $("#radio").animate({bottom: "-75vh"}, 500)
    }
});

$(document).on("click", "#connect" ,function(event) {
    event.preventDefault(); 
    const val = $("#channel-input").val()
    if (val.length > 0) {
        $.post('https://'+scriptName+'/joinRadio', JSON.stringify({channel: val}));
    }
});

$(document).on("click", "#leave" ,function(event) {
    event.preventDefault(); 
    $.post('https://'+scriptName+'/leaveRadio', JSON.stringify({}));
});

$(document).on("click", "#voldown" ,function(event) {
    event.preventDefault(); 
    $.post('https://'+scriptName+'/voldown', JSON.stringify({}), function(vol){
        $(".top-menu-vol").html("VOL: "+vol+"%")
    });
});

$(document).on("click", "#volup" ,function(event) {
    event.preventDefault(); 
    $.post('https://'+scriptName+'/volup', JSON.stringify({}), function(vol) {
        $(".top-menu-vol").html("VOL: "+vol+"%")
    });
});

$(document).on("click", "#mute" ,function(event) {
    event.preventDefault(); 
    $.post('https://'+scriptName+'/mute', JSON.stringify({}), function(vol) {
        $(".top-menu-vol").html("VOL: "+vol+"%")
    });
});