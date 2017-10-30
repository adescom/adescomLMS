var ec = (function () {

    var select_group_radio = null;
    var select_city_radio = null;

    var select_group_panel = null;
    var select_state_panel = null;
    var select_county_panel = null;
    var select_commune_panel = null;

    var select_state = null;
    var select_county = null;

    var initializeInternal = function (geo_id) {

        select_group_radio = document.getElementById('emergencycontext_by_group');
        select_city_radio = document.getElementById('emergencycontext_by_city');

        select_group_panel = document.getElementById('select_group_panel');
        select_state_panel = document.getElementById('select_state_panel');
        select_county_panel = document.getElementById('select_county_panel');
        select_commune_panel = document.getElementById('select_commune_panel');

        select_state = document.getElementById('select_state');
        select_county = document.getElementById('select_county');

        select_group_radio.onclick = function () {
            selectGroupInternal();
        };

        select_city_radio.onclick = function () {
            selectCityInternal();
        };

        select_state.onchange = function () {
            select_county_panel.style.display = '';
            select_commune_panel.style.display = 'none';
            xajax_getGeoLocationCountiesByState(select_state.value);
        };

        select_county.onchange = function () {
            select_commune_panel.style.display = '';
            xajax_getGeoLocationCommunesByState(select_county.value);
        };

        if (geo_id) {
            selectCityInternal(geo_id);
        } else {
            selectGroupInternal();
        }

    };

    var selectGroupInternal = function () {
        select_group_radio.checked = true;
        select_city_radio.checked = false;
        select_group_panel.style.display = '';
        select_state_panel.style.display = 'none';
        select_county_panel.style.display = 'none';
        select_commune_panel.style.display = 'none';
    };

    var selectCityInternal = function (geo_id) {
        select_group_radio.checked = false;
        select_city_radio.checked = true;
        select_group_panel.style.display = 'none';
        select_state_panel.style.display = '';
        if (geo_id) {
            select_county_panel.style.display = '';
            select_commune_panel.style.display = '';
        } else {
            select_county_panel.style.display = 'none';
            select_commune_panel.style.display = 'none';
        }
    };
    
    return {
        initialize: function (by_group) {
            initializeInternal(by_group);
        }
    };

})();