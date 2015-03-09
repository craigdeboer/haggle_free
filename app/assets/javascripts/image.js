// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

	$("#listingpic").Jcrop({
		onSelect: getCoords,
		aspectRatio: 1,
		setSelect: [0, 0, 600, 600]

	});

	function getCoords(c) {

		$("#x-value-input").val(c.x);
		$("#y-value-input").val(c.y);
		$("#width-value-input").val(c.w);
		$("#height-value-input").val(c.h);

	}

});