function coordinatesMap(latlng) {
    var myOptions = { 
      zoom: 14, // default is 8  
      center: latlng, 
      mapTypeId: google.maps.MapTypeId.ROADMAP 
    }; 
    var map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions); 
    var contentString = '<div id="content">'+
          '<div id="siteNotice">'+
          '</div>'+
          '<div id="bodyContent">'+
          latlng+
          '</div>'+
          '</div>';                

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });
    var marker = new google.maps.Marker({
        position: latlng,
        map: map,
    });
      marker.addListener('click', function() {
      infowindow.open(map, marker);
    });
}

function globalMap() {
    var latlng = new google.maps.LatLng("34.0621361","-118.4463541");
    var myOptions = { 
      zoom: 0, // default is 8  
      center: latlng, 
      mapTypeId: google.maps.MapTypeId.ROADMAP 
    }; 
    var map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);             
}

function geocodeMap(location) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode( { 'address': location }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            var latlng = results[0].geometry.location;
            coordinatesMap(latlng);
          } 
         else {
            globalMap();                      
        }
      });           
}