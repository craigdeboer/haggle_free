var ready = function() {
	$('#user-options-dropdown').click(function() {
		$("#menu #user-dropdown-links").slideToggle();
	});
}; 

$(document).ready(ready);
$(document).on('page:load', ready);