//Thanks to Phil Haack for this script, which I blatantly ripped off.
//https://github.com/Haacked/haacked.com/blob/4d3ab2b0e18ed03fd258d0f639e87d5da55f17c5/js/slash.js

(function($) {
	// Append caption after pictures
	$('.article-wrap img').each(function(i) {
		var alt = this.alt;
		var parent = $(this).parent();

		if (alt != '') {
			var element = $(this);
			if (parent.is('a')) {
				element = parent;
			}
			element.after('<br/><em><span class="caption">'+alt+'</span></em>');
		}

		if (!parent.is('a')) {
			$(this).wrap('<a href="'+this.src+'" title="'+alt+'" />');
		}
	});
})(jQuery);