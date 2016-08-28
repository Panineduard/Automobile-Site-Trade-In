/**
 * Created by volkswagen1 on 27.08.2016.
 */
$(document).ready(function () {
    var start_pos = $('#stick_menu').offset().top;
    $(window).scroll(function () {
        if ($(window).scrollTop() + 20 >= start_pos) {
            if ($('#stick_menu').hasClass() == false) {
                $('#stick_menu').addClass('to_top');
                $('#help_div').addClass('help_div')

            }
            if ($('#search_car').hasClass() == false) {
                $('#search_car').addClass('fix_position_of_search');
            }
        }
        else {
            $('#stick_menu').removeClass('to_top');
            $('#help_div').removeClass('help_div');
            $('#search_car').removeClass('fix_position_of_search');
        }

    });
    $('#result').animate({opacity: 1}, 1000);
});