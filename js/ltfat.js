var baseurl = "."

$(document).ready(function() {
    includefile();
    $('body').show();
});


function relativetoabsolute(){
}

function includefile(){
    $('.include').each(function () {
    var included_file = $(this).attr('file');
    console.log(included_file);
    if (typeof included_file != "undefined")
    {
        $(this).load(included_file,function (){
            $(this).find("img").attr('src',function()
                {
                    var n =this.src.lastIndexOf('#BASEURL#');
                    if( n!= -1)
                    {
                        var valid = this.src.substring(n);
                        var retval = valid.replace(/^#BASEURL#/,baseurl);

                        console.log('Old:' + this.src);
                        console.log('New:' + retval);
                        return retval;
                    }
                });
        });
    }
    else
    {
        console.error("#include is missing file");
    }
    });
}
