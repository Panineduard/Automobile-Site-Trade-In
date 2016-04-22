/**
 * Created by Panin Eduard on 02.04.2016.
 */

$(document).ready(function getRegions() {
    var engine_parameter_val=['','gasoline','disel','elektro','hybrid','gas','other'];
    var gearbox_parameter_val=['','another','auto','mechanical'];
    var brand=' ';
    var year_made=' ';
    var region= ' ';
    var model=' ';
    var gearbox=' ';
    var engine=' ';
    $.ajax({
        dataType: 'json',
        url: '/getCarsOptions',
        method: "GET",
        //data: { id: $('#id_car').val()},
        success: function (jsondata) {
            if(jsondata!=null) {
                brand = jsondata.brand;
                year_made = jsondata.yearMade;
                region = jsondata.region;
                model = jsondata.model;
                gearbox=jsondata.transmission;
                engine=jsondata.enginesType;
            }
        }

    });
    $.ajax({
        dataType: 'json',
        url: '/getBrands',
        success: function (jsondata) {

            for(var i=0;i<engine_parameter_val.length;i++){
                if(engine_parameter_val[i]==engine){
                    $('#id_engine').append('<option selected="selected" value="'+engine_parameter_val[i]+'">'+engine_parameter[i]+'</option>');
                }
                else{
                    $('#id_engine').append('<option value="'+engine_parameter_val[i]+'">'+engine_parameter[i]+'</option>');
                }
            }
            for(var i=0;i<gearbox_parameter_val.length;i++){
                if(gearbox_parameter_val[i]==gearbox){
                    $('#id_gearbox').append('<option selected="selected" value="'+gearbox_parameter_val[i]+'">'+gearbox_parameter[i]+'</option>');
                }
                else{
                    $('#id_gearbox').append('<option value="'+gearbox_parameter_val[i]+'">'+gearbox_parameter[i]+'</option>');
                }
            }
            for(var i=0;i<jsondata.length;i++){

                if(brand==jsondata[i].brand){
                    $('#id_make').append('<option selected="selected" value="'+jsondata[i].brand+'">'+jsondata[i].brand+' </option>');
                    p_delete(jsondata[i].brand,model);
                }
                else{
                    $('#id_make').append('<option value="'+jsondata[i].brand+'">'+jsondata[i].brand+' </option>');
                }

            }

        }
    });
    $.ajax({
        dataType: 'json',
        url: '/getRegions',
        success: function (jsondata) {

            for(var i=0;i<jsondata.length;i++){
                var value='';

                value=jsondata[i].id;

                if(region==jsondata[i].id){
                    $('#id_region').append('<option selected="selected" value="'+value+'">'+jsondata[i].name+'</option> ');
                }
                else{
                    $('#id_region').append('<option value="'+value+'">'+jsondata[i].name+'</option> ');
                }
            }

        }
    });


    $.ajax({
        dataType: 'json',
        url: '/getYears',
        success: function (jsondata) {
            for(var i=0;i<jsondata.length;i++){
                if(year_made==jsondata[i].year){
                    $('#id_year_from').append('<option selected="selected" value="'+jsondata[i].year+'">'+jsondata[i].year+'</option> ');
                }
                else{
                    $('#id_year_from').append('<option value="'+jsondata[i].year+'">'+jsondata[i].year+'</option> ');

                }

            }

        }
    });

});
