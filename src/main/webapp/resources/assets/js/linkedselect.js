/**
 * Created by Эдуард on 27.11.15.
 */

function syncList(){}



syncList.prototype.sync = function()
{
    for (var i=0; i < arguments.length-1; i++)	document.getElementById(arguments[i]).onchange = (function (o,id1,id2){return function(){o._sync(id1,id2);};})(this, arguments[i], arguments[i+1]);
    document.getElementById(arguments[0]).onchange();//Р·Р°РїСѓСЃРєР°РµРј РѕР±СЂР°Р±РѕС‚С‡РёРє onchange РїРµСЂРІРѕРіРѕ СЃРµР»РµРєС‚Р°, С‡С‚РѕР±С‹ РїСЂРё Р·Р°РіСЂСѓР·РєРµ СЃС‚СЂР°РЅРёС†С‹ Р·Р°РїРѕР»РЅРёС‚СЊ РґРѕС‡РµСЂРЅРёРµ СЃРµР»РµРєС‚С‹ Р·РЅР°С‡РµРЅРёСЏРјРё.
}

syncList.prototype._sync = function (firstSelectId, secondSelectId)
{
    var firstSelect = document.getElementById(firstSelectId);
    var secondSelect = document.getElementById(secondSelectId);

    secondSelect.length = 0;

    if (firstSelect.length>0)
    {
        var optionData = this.dataList[ firstSelect.options[firstSelect.selectedIndex==-1 ? 0 : firstSelect.selectedIndex].value ];
        for (var key in optionData || null) secondSelect.options[secondSelect.length] = new Option(optionData[key], key);

        if (firstSelect.selectedIndex == -1) setTimeout( function(){ firstSelect.options[0].selected = true;}, 1 );
        if (secondSelect.length>0) setTimeout( function(){ secondSelect.options[0].selected = true;}, 1 );
    }
    secondSelect.onchange && secondSelect.onchange();
};
