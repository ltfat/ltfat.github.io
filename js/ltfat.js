var baseurl = "."

$(document).ready(function() {
    includefile();
});

function includefile(){
    var inLen = $('.include[file]').length;
    if(inLen == 0)
    {
        // just make body visible and exit
        $('body').css({display:'block'});
    }

    $('.include[file]').each(function (idx, el) {
        var included_file = $(this).attr('file');
        //console.log(included_file);

        var wasinhead = $("head").html();
        $(this).load(included_file,function (){

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
        // This has to be inside load because it is called asynchronously
        // And we want to run it only after the last item was loaded
        if(idx==inLen-1)
        {  
            $('body').css({display:'block'});
        }
        });
        // Remove the include class and file attribute to avoid including it again
        $(this).removeAttr('file');
        $(this).removeClass('include');
    });
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
