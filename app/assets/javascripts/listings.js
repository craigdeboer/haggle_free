// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

var startDate;
var nextDate;
var nextPrice;
$("#listing_sell_method_auction").on("click", function () {
	$("#nested-price-fade-form").hide();
	$("#nested-auction-form").slideDown(800);
}); 
$("#listing_sell_method_price").on("click", function () {
	$("#nested-auction-form").hide();
	$("#nested-price-fade-form").slideDown(800);
}); 

$("#price-interval-preview").click(function(event) {
	event.preventDefault();
	var errorCount = 0;
	var startPrice = ($("#start-price-input").val());
	var priceInterval
	var priceDecrementValue = ($("#price-decrement-input").val());

	if(/^\d+(?:\.\d{0,2})$/.test(startPrice) || /^\d+$/.test(startPrice)) {
		startPrice = parseFloat(startPrice);
	}
	else {
		startPrice = "The starting price you entered is not a number.";
		errorCount += 1;
	}


	var priceIntervalValue = $("#price-interval-field [type=radio]:checked").val();
	priceInterval = parseInt(priceIntervalValue);
	if(!priceInterval) {
		errorCount += 2;
		priceInterval = "You forgot to choose a price interval."
	}


	if(/^\d+$/.test(priceDecrementValue) || /^\d+(?:\.\d{0,2})$/.test(priceDecrementValue)) {
		priceDecrement = parseFloat(priceDecrementValue);
	}
	else {
		priceDecrement = "The price interval decrease amount you entered is not a number.";
		errorCount += 4;
	}

	if((startPrice - (7 * priceDecrement)) < 0 ) {
		priceDecrement = "Your price decrement is too high; it will take your item below $0";
		errorCount += 8;
	}
	console.log(errorCount);
	$("#error-message").html("");

	if(errorCount === 0) {

		
		for (i = 0; i <= 7; i++) { 
			startDate = new Date();
			nextDate = startDate;
			nextDate.setDate(startDate.getDate() + (priceInterval * i))	
			nextPrice = startPrice - (priceDecrement * i);
			$("#interval-" + i + "-date").html(nextDate.toDateString());
			$("#interval-" + i + "-price").html("$" + nextPrice.toFixed(2));
		}

	} else {
		
		if((errorCount % 2) === 1) {
			$("#error-message").append('<p class="one"></p>');
			$("#error-message p.one").html(startPrice);
			errorCount -= 1;
		} 
		if((errorCount % 4) === 2) {
			$("#error-message").append('<p class="two"></p>');
			$("#error-message p.two").html(priceInterval);
			errorCount -= 2;
		} 
		if((errorCount % 8) === 4) {
			$("#error-message").append('<p class="three"></p>');
			$("#error-message p.three").html(priceDecrement);
			errorCount -= 4;
		} 
		if(errorCount === 8) {
			$("#error-message").append('<p class="four"></p>');
			$("#error-message p.four").html(priceDecrement);
		}

	}

	});

	
	



}); 