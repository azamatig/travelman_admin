import 'package:admin/utils/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

showPlacePreview(
    context,
    String name,
    String location,
    String imageUrl_1,
    String description,
    double lat,
    double lng,
    String startpointName,
    String endpointName,
    double startpointLat,
    double startpointLng,
    double endpointLat,
    double endpointLng,
    String price,
    List paths) {

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.50,
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      child: CustomCacheImage(imageUrl: imageUrl_1, radius: 0.0)
                      
                      // Image(
                      //     fit: BoxFit.cover, image: NetworkImage(imageUrl_1)),
                    ),
                    Positioned(
                      top: 10,
                      right: 20,
                      child: CircleAvatar(
                        child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 10),
                        height: 3,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_on, size: 16, color: Colors.grey),
                          Text(
                            location,
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Latitude: ',
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: lat.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700])),
                              ])),
                          SizedBox(
                            width: 5,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Longitude: ',
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: lng.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700])),
                              ])),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Html(
                          defaultTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                          data: '''$description'''),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Guide Details',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w800)),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 10),
                        height: 3,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(
                                  text: 'Startpoint Name: ',
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: startpointName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700])),
                              ])),
                          Spacer(),
                          RichText(
                              text: TextSpan(
                                  text: 'Endpoint Name: ',
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: endpointName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700])),
                              ])),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(
                                  text: 'Startpoint Latitude: ',
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: startpointLat.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700])),
                              ])),
                          Spacer(),
                          RichText(
                              text: TextSpan(
                                  text: 'Startpoint Longitude: ',
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: startpointLng.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700])),
                              ])),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(
                                  text: 'Endpoint Latitude: ',
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: endpointLat.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700])),
                              ])),
                          Spacer(),
                          RichText(
                              text: TextSpan(
                                  text: 'Endpoint Longitude: ',
                                  style: TextStyle(color: Colors.grey),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: endpointLng.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700])),
                              ])),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Estimated Cost: ',
                              style: TextStyle(color: Colors.grey),
                              children: <TextSpan>[
                            TextSpan(
                                text: price,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[700])),
                          ])),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Paths',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800)),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 10),
                        height: 2,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Container(
                        child: paths.length == 0
                            ? Center(
                                child: Text('No path list were added'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: paths.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text(index.toString()),
                                    ),
                                    title: Text(paths[index]),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      });
}
