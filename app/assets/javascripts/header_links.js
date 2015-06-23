var ready = function() {
	// $('#user-options-dropdown').click(function() {
	// 	$("#menu #user-dropdown-links").slideToggle();
	// });
	$('#user-options-dropdown').click(function(e) {
		$("#menu #user-dropdown-links").slideToggle();
		e.stopPropagation();
	});
	$(document).click(function() {
		$("#menu #user-dropdown-links").slideUp();
	});
}; 

$(document).ready(ready);
$(document).on('page:load', ready);