/* Author:

 */

$(document).ready(function() {
	$('a.panel').click(function() {
		var panel = $(this);
		var id = panel.attr('id');
		if (panel.hasClass('open')) {
			panel.removeClass('open').addClass('closed');
			$('#panel_' + id).hide();
		} else {
			panel.removeClass('closed').addClass('open');
			$('#panel_' + id).show();
		}
		return false;
	});
});