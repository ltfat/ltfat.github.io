// Get base URL
var loc = window.location;
var baseurl = loc.protocol + "//" + loc.host;

$(document).ready(function(){ 
    // Just to be sure
    $('body').css('display','none');
    // Fill in the included parts 
    includefiles();
});

function includefiles(){
    var inLen = $('.include[file]').length;

    $('.include[file]').each(function (idx, el) {
        var included_file = $(this).attr('file');

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

        $(this).find("a, link[href] script[href]").attr('href',function(index,currVal){
            return relativetoabsolute(currVal);
        });

        // Remove the include class and file attribute to avoid including it again
        $(this).removeAttr('file');
        $(this).removeClass('include');
        // This has to be inside load because it is called asynchronously
        // And we want to run it only after the last item was loaded
        if(idx==inLen-1)
        {  
            // Remove active item in menu
            $("nav .nav .active").removeClass("active");
            var chref = $(location).attr("href").substr(baseurl.length+1);

            var isTopLevelFile = chref.indexOf('.html') > -1 &&
                chref.indexOf('/') == -1 ;

            if(chref.length == 0){
                // Theat the home path differently
                $("nav .nav li").first().addClass("active"); 
            }
            else{
                if(isTopLevelFile){
                    $("nav .nav li a[href$='"+chref+"']")
                        .last().parent().addClass('active');
                }
                else
                {
                    // Get rid of the trailing filename
                    chref = chref.substr(chref,chref.lastIndexOf('/'));
                    console.log("Current: " + chref);
                    $("nav .nav li a[href]").filter(function(){
                        var href = this.href.substr(baseurl.length+1)
                        console.log("Menu:" + href);
                    return chref.indexOf(href,chref.length - href.length) !== -1;
                    }).last().parent().addClass("active");
                }
            }
            $('body').css({display:'block'});
        }
        });
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
