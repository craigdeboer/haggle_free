// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

	$("#listingpic").Jcrop({
		onSelect: getCoords,
		aspectRatio: 1.5,
		setSelect: [0, 0, 400, 300]

	});

	function getCoords(c) {

		var ratio = $('#image-ratio').val();
		$("#x-value-input").val(Math.round(c.x * ratio));
		$("#y-value-input").val(Math.round(c.y * ratio));
		$("#width-value-input").val(Math.round(c.w * ratio));
		$("#height-value-input").val(Math.round(c.h * ratio));

	}

	$('#listing-thumbnails img').click( function() {
		var imageThumb = $(this).attr('src');
		var imageLarge = imageThumb.replace("thumb", "large");
		$('#main-listing-image').html("<img class='main-image-display' src='" + imageLarge + "'>");
	});

});