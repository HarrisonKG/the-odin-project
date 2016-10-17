$(document).ready(function(){
	showGrid($("#numboxes").val());

$("button").click(function(e){
	e.preventDefault(); // prevents page reload
	showGrid($("#numboxes").val());
});

function showGrid(x) {
	var $wrap = $(".wrapper").html("");
	// Calculates box dimensions with 1px buffer to prevent overflow
	var $squareSize = ($wrap.width()-1)/x;
	// Calculates and places total number of boxes
	for(var i=0; i<x; i++){
		for(var j=0; j<x; j++){
			$wrap.append($("<div />").addClass("square").height($squareSize).width($squareSize));
		}
	}
	checkMode();
}

function checkMode(){
	var newMode = $("#dropdown").val();
	if(newMode == "norm"){
		normalMode();
	} else if(newMode == "rainbow"){
		rainbowMode();
	} else if(newMode == "fade"){
		fadeMode();
	} else if (newMode == "rainbowfade"){
		rainbowfadeMode();
	}
}

function normalMode(){
	$(".square").mouseenter(function(){
	$(this).css("background", "white");
});
}

function rainbowMode(){
	$(".square").mouseenter(function(){
		$(this).css("background", getRandomColor());
});
}

function getRandomColor() {
    var letters = "0123456789ABCDEF".split("");
    var color = "#";
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

function fadeMode() {
	$(".square").mouseenter(function(){
		$(this).css("opacity", fadeOut($(this).css("opacity")));
});
}

function fadeOut(x) {
	console.log(x);
	return 0.95 * x;
}

function rainbowfadeMode(){
	$(".square").mouseenter(function(){
		$(this).css("background", getRandomColor());
		$(this).fadeTo( 3000, 0.25, function() { $(this).css("background", "black"); });
		$(this).fadeTo(3000, 1);
	});
}

});
