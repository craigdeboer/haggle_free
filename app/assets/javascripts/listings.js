// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

$("#listing_sell_method_auction").on("click", function () {
	$("#nested-price-fade-form").hide();
	$("#nested-auction-form").slideDown(800);
}); 
$("#listing_sell_method_price").on("click", function () {
	$("#nested-auction-form").hide();
	$("#nested-price-fade-form").slideDown(800);
}); 

});