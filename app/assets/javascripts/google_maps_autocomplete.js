$(document).ready(function() {
  var gear_address = $('#search_location').get(0);

  if (gear_address) {
    var autocomplete = new google.maps.places.Autocomplete(gear_address, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    google.maps.event.addDomListener(gear_address, 'keydown', function(e) {
      if (e.keyCode == 13) {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
});

function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  $('#search_location').trigger('blur').val([components.address, components.city, components.country_code].compact.join(', '));
  // $('#search_zip_code').val(components.zip_code);
  // $('#search_city').val(components.city);
  // $('#search_latitude').val(components.latitude)
  // $('#search_longitude').val(components.longitude)
  // if (components.country_code) {
  //   $('#search_country').val(components.country_code);
  // }
}

function getAddressComponents(place) {
  // var latitude = place.geometry.location.lat();
  // var longitude = place.geometry.location.lng()
  var street_number = null;
  var route = null;
  var zip_code = null;
  var city = null;
  var country_code = null;
  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {
      var type = component.types[j];
      if (type == 'street_number') {
        street_number = component.long_name;
      } else if (type == 'route') {
        route = component.long_name;
      } else if (type == 'postal_code') {
        zip_code = component.long_name;
      } else if (type == 'locality') {
        city = component.long_name;
      } else if (type == 'country') {
        country_code = component.short_name;
      }
    }
  }

  return {
    address: street_number == null ? route : (street_number + ' ' + route),
    zip_code: zip_code,
    city: city,
    country_code: country_code
  };
}

function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      var gear_address = $('#search_location').get(0);
      var autocomplete = new google.maps.places.Autocomplete(gear_address, { types: ['geocode'] });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}
