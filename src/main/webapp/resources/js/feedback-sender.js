/**
 * Created by Panin Eduard  on 22.04.2016.
 */
$(document).ready(function getRegions() {
    $('input#send_feedback').click(function(){
        var email = $('.email').val();
        var message =$('.message').val();
        var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
if(email==""||message==""){
    alert(empty_field);
    return
}
        else {
    if (emailReg.test(email)) {
        $.post("/save_message", {email: email, message: message})
            .done(function (data) {
            });
        alert(successful);
        $('#feedback')[0].reset();
        $('#modal_close').click();
    }
    else {
        alert(unsuccessful);
    }

}


    })
});