$(document).ready(function(){
    // 
    // globalfun list and toolboxversion variables are defined
    if(typeof globalfunlist === 'undefined'){
        $('#jumplist').html('No function list found');
    }
    else{
        // Build a combobox with function names
        var jstr = '';
        jstr += '<div class="input-group pull-right">';
        jstr += '<span class="input-group-addon"><b>Go to function</b></span>';
        jstr += '<select class="form-control input-sm">';

        jstr += '<option value="start/index">---Home---</option>'; 
        for(var fname in globalfunlist){
            var relpath = globalfunlist[fname];
            jstr += '<option value="'+relpath+'">'+fname+'</option>';
        }
        jstr += '</select>';
        jstr += '</div>';
        $('#jumplist').html(jstr);

        var baseurl = loc.protocol + "//" + loc.host + '/doc';
        var valuestr = $(location).attr("href").substr(baseurl.length+1);
        if(valuestr.indexOf('.html') > -1){
            if(valuestr.indexOf('_code.html') > -1){
                valuestr = valuestr.substr(0,valuestr.indexOf('_code.html'));
            }
            else{
                valuestr = valuestr.substr(0,valuestr.indexOf('.html'));
            }
            //$('#jumplist option[value="'+valuestr.substr(valuestr.length-4)+'"]').attr('selected','selected');
            $('#jumplist option[value="'+valuestr+'"]').attr('selected','selected');
        }

        // Redirect browser to new location on combobox change
        $('#jumplist select').change(function(){
            $('#jumplist option[selected]').removeAttr('selected');
            window.location.replace('../' + this.value + '.html');
        });



    }

// Add classes to the code-doc switch
$('#codeswitch a').addClass('btn btn-info btn-block');
// Add classes to seealso menu and move menutitle to the list
var menutitle = $('#seealso #menutitle').html();
$('#seealso #menutitle').html('<li><a href=""><b>'+menutitle +'</b></a></li>');
$('#seealso ul').addClass('nav doc-sidenav affix-top')
    $('#seealso #menutitle > li').prependTo('#seealso ul');


});


