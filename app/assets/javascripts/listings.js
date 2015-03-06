// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

	$("#mypic").Jcrop();


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
		var startDate;
		var nextDate;
		var nextPrice;
		var errorCount = 0;
		var startPrice = ($("#start-price-input").val());
		var priceDecrement = ($("#price-decrement-input").val());
		var priceInterval = parseInt($("#price-interval-field [type=radio]:checked").val());

		// Check to see if the start price is all numbers or a number with 
		// 1 or 2 digits after the decimal. If it is valid, convert the string
		// to a float. If not, save an error message in the variable instead
		// and adjust the error count.
		if(/^\d+(?:\.\d{0,2})$/.test(startPrice) || /^\d+$/.test(startPrice)) {
			startPrice = parseFloat(startPrice);
		}
		else {
			startPrice = "The starting price you entered is not a number.";
			errorCount += 1;
		}

		// If price interval is null adjust the error count and store an 
		// error string in the variable.
		if(!priceInterval) {
			errorCount += 2;
			priceInterval = "You forgot to choose a price interval."
		}

		// Check if price decrement value is a valid number containing only digits 
		// or a decimal place with 1 or 2 digits after the decimal. 
		// If it's valid, convert the string to a float. If not, store an 
		// error message string in the variable and adjust error count.
		if(/^\d+$/.test(priceDecrement) || /^\d+(?:\.\d{0,2})$/.test(priceDecrement)) {
			priceDecrement = parseFloat(priceDecrement);
		}
		else {
			priceDecrement = "The price interval decrease amount you entered is not a number.";
			errorCount += 4;
		}

		// If the price decrement value is too high, it will result in a negative 
		// price after 7 intervals so produce and error message if that's the case.
		if((startPrice - (7 * priceDecrement)) < 0 ) {
			priceDecrement = "Your price decrement is too high; it will take your item below $0";
			errorCount += 8;
		}
		
		// Clear the error messages.
		$("#error-message").html("");

		// If there aren't any errors, then display the preview.
		if(errorCount === 0) {

			// This loop happens 7 times and is used to generate the 7 price change
			// dates and their associated prices.
			for (i = 0; i <= 7; i++) { 
				startDate = new Date();
				nextDate = startDate;
				nextDate.setDate(startDate.getDate() + (priceInterval * i))	
				nextPrice = startPrice - (priceDecrement * i);
				$("#interval-" + i + "-date").html(nextDate.toDateString());
				$("#interval-" + i + "-price").html("$" + nextPrice.toFixed(2));
			}

		// If there are errors, display the messages.
		} else {
			
			// errorCount variable adjusted in such a way to identify which
			// errors are present using a single if statement for each error.
			// For example, since the start price error adds 1 to the errorCount
			// and all the other errors add an even number, if the number is odd
			// it's an indication that error 1 was present.
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