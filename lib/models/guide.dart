
import 'package:cloud_firestore/cloud_firestore.dart';

class Guide {

  String startpointName;
  String endpointName;
  double startpointLat;
  double startpointLng;
  double endpointLat;
  double endpointLng;
  String price;
  List paths;
  

  Guide({
    this.startpointName,
    this.endpointName,
    this.startpointLat,
    this.startpointLng,
    this.endpointLat,
    this.endpointLng,
    this.price,
    this.paths
    
    
  });


  factory Guide.fromFirestore(DocumentSnapshot snapshot){
    var d = snapshot.data();
    return Guide(
       startpointName: d['startpoint name'],
       endpointName: d['endpoint name'],
       startpointLat: d['startpoint lat'],
       startpointLng: d['startpoint lng'],
       endpointLat: d['endpoint lat'],
       endpointLng: d['endpoint lng'],
       price: d['price'],
       paths: d['paths']


    );
  }
}