part of 'freight_search.dart';

class FreightSearchController {
  City fromCity;
  int fromRadius;
  City toCity;
  int toRadius;
  bool antt;
  LatLng position;

  FreightSearchController({
    this.fromCity,
    this.fromRadius = 100,
    this.toCity,
    this.toRadius = 100,
    this.antt = false,
    this.position,
  });

  FreightSearchQuery getFreightSearchQuery() {
    String toCityHash;
    int toRadiusTemp;
    
    if(toCity != null && toRadius != 0){
      toCityHash = toCity.hash;
      toRadiusTemp = toRadius;
    }
    
    return FreightSearchQuery(
      position: null,
      antt: antt,
      destinationCityHash: toCityHash,
      destinationRadiusInKM: toRadiusTemp,
      originCityHash: fromCity.hash,
      originRadiusInKM: fromRadius,
    );
  }

  FreightSearchQuery getFreightSearchQueryPosition() {
    String toCityHash;
  
    if(toCity != null){
      toCityHash = toCity.hash;
    }
    
    return FreightSearchQuery(
      position: position,
      antt: antt,
      destinationCityHash: toCityHash,
      destinationRadiusInKM: toRadius,
      originCityHash: null,
      originRadiusInKM: null,
    );
  }
}
