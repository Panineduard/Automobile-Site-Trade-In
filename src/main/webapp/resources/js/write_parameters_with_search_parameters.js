/**
 * Created by Panin Eduard on 26.03.2016.
 */

$(document).ready(function getRegions() {
    var brand=' ';
    var year_from=' ';
    var year_to=' ';
    var region= ' ';
    var model=' ';
    var gearbox=' ';
    var engine=' ';
    var engine_parameter_val=['','gasoline','disel','elektro','hybrid','gas','other'];

    var gearbox_parameter_val=['','another','auto','mechanical'];


    $.ajax({
        dataType: 'json',
        url: '/getSearchOptions',
        success: function (jsondata) {
            if(jsondata!=null) {
                brand = jsondata.make;
                year_from = jsondata.year_from;
                year_to = jsondata.year_to;
                region = jsondata.region;
                model = jsondata.model;
                gearbox=jsondata.gearbox;
                engine=jsondata.engine;


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
                if(year_from==jsondata[i].year){
                    $('#id_year_from').append('<option selected="selected" value="'+jsondata[i].year+'">'+jsondata[i].year+'</option> ');
                }
                else{
                    $('#id_year_from').append('<option value="'+jsondata[i].year+'">'+jsondata[i].year+'</option> ');

                }
                if(year_to==jsondata[i].year){
                    $('#id_year_to').append('<option selected="selected" value="'+jsondata[i].year+'">'+jsondata[i].year+'</option> ');

                }
                else {
                    $('#id_year_to').append('<option value="' + jsondata[i].year + '">' + jsondata[i].year + '</option> ');
                }
            }

        }
    });


});
