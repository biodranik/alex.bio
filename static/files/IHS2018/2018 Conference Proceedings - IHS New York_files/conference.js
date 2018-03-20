jQuery( document ).ready(function() {
//jQuery('.gdlr-page-title').css("display", "none");
jQuery('.session-speaker').css("display", "none");
var pathname = window.location.pathname;
//alert(pathname);
//if(pathname == "/north-america/speaker/")
//{
	
	//jQuery('.gdlr-page-title').text("SPEAKERS");
	
//}
//jQuery('.gdlr-page-title').show();


jQuery('.moderator').each(function(){
	
jQuery(this).prependTo(jQuery(this).parent());
});
jQuery('.session-speaker').fadeIn();
	//alert('something works');
});