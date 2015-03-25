// Get base URL
var loc = window.location;
var baseurl = loc.protocol + "//" + loc.host + "/";
var baseurl = 'http://localhost:8000';

$(document).ready(function(){ 
    // Just to be sure
    $('body').css('display','none');
    includefiles();

});

function includefiles(){
    var inLen = $('.include[file]').length;

    $('.include[file]').each(function (idx, el) {
        var included_file = $(this).attr('file');
        //console.log(included_file);

        var wasinhead = $("head").html();
        $(this).load(included_file,function (response,status,xhr){
        if(status!=='success')
        {
            console.log('No sukcess');
        }
            if($(this).is("head"))
        {
            // console.log('This was head');
            $(this).html(function(i,origText){
                return  wasinhead + origText;
            });
            $(this).removeAttr('class');
        }

        $(this).find("img").attr('src',function(index,currVal){
            return relativetoabsolute(currVal);
        });

        $(this).find("a").attr('href',function(index,currVal){
            return relativetoabsolute(currVal);
        });

        $(this).find("link[href]").attr('href',function(index,currVal){
            return relativetoabsolute(currVal);
        });

        $(this).find("script[href]").attr('href',function(index,currVal){
            return relativetoabsolute(currVal);
        });


        // This has to be inside load because it is called asynchronously
        // And we want to run it only after the last item was loaded
        if(idx==inLen-1)
        {  
            $('body').css({display:'block'});
            // Remove active item in menu
            $("nav .nav .active").removeClass("active");
            var chref = $(location).attr("href").substr(baseurl.length+1);

            console.log(chref);
            $("nav .nav li a[href]").filter(function(){
                var href = this.href.substr(baseurl.length+1)
                console.log(href);
            return chref.indexOf(href,chref.length - href.length) !== -1;
            }).parent().addClass("active");
        }
        });
        // Remove the include class and file attribute to avoid including it again
        $(this).removeAttr('file');
        $(this).removeClass('include');
    });
    if(inLen == 0)
    {
        // just make body visible and exit
        $('body').css({display:'block'});
    }
}

function relativetoabsolute(v){
    var n = v.lastIndexOf('#BASEURL#');
    if( n!= -1)
    {
        var valid = v.substring(n);
        var retval = valid.replace(/^#BASEURL#/,baseurl);

        //console.log('Old:' + v);
        //console.log('New:' + retval);
        return retval;
    }
}
