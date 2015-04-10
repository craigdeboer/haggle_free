var ready = function() {

	$('#bid-page input.string').focus(function() {
		$(this).val('$');
	});	


}; 

$(document).ready(ready);
$(document).on('page:load', ready);