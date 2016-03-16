$(document).ready(function(){

$("td.clickable").click(function(){
$('#audplayer source').remove();
$('#audplayer').prepend('<source src="'+$(this).attr("data-file")+'" type="audio/ogg">');
$('#audplayer').trigger("load");
$('#audplayer').trigger("play");

$("td.clickable").removeAttr("style");

$(this).css("background-color","red");
var filepath = $(this).attr("data-file");
$('#loadedfile').html('<a href="'+filepath+'">'+filepath+'</a>');

});


$('.playerdiv').stick_in_parent();
// .on("sticky_kit:stick", function(e) {
//     $("#stickytable").css("background-color","rgb(100,100,100)");
//     $("#stickytable").css("border-radius","5px");
//   })
//   .on("sticky_kit:unstick", function(e) {
//     $("#stickytable").removeAttr("style");
//   });
});



