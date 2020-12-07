import 'package:admin/blocs/admin_bloc.dart';
import 'package:admin/models/place.dart';
import 'package:admin/pages/comments.dart';
import 'package:admin/pages/update_place.dart';
import 'package:admin/utils/cached_image.dart';
import 'package:admin/utils/dialog.dart';
import 'package:admin/utils/next_screen.dart';
import 'package:admin/utils/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class FeaturedPlaces extends StatefulWidget {
  const FeaturedPlaces({Key key}) : super(key: key);

  @override
  _FeaturedPlacesState createState() => _FeaturedPlacesState();
}

class _FeaturedPlacesState extends State<FeaturedPlaces> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _isLoading;
  List<DocumentSnapshot> _snap = new List<DocumentSnapshot>();
  List<Place> _data = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String collectionName = 'places';
  DocumentSnapshot _lastVisible;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getData();
  }

  

  Future<Null> _getData() async {
    await context.read<AdminBloc>().getFeaturedList()
    .then((featuredList) async {
      QuerySnapshot data;
    if (_lastVisible == null)
      data = await firestore
          .collection(collectionName)
          .where('timestamp', whereIn: featuredList)
          .limit(10)
          .get();
    else
      data = await firestore
          .collection(collectionName)
          .where('timestamp', whereIn: featuredList)
          .startAfter([_lastVisible['timestamp']])
          .limit(10)
          .get();

    if (data != null && data.docs.length > 0) {
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        setState(() {
          _isLoading = false;
          _snap.addAll(data.docs);
          _data = _snap.map((e) => Place.fromFirestore(e)).toList();
        });
      }
    } else {
      setState(() => _isLoading = false);
      openToast(context, 'No more content available');
    }
    return null;

    });
    
  }



  navigateToReviewPage(context, timestamp, name) {
    nextScreenPopuup(
        context,
        CommentsPage(
          collectionName: collectionName,
          timestamp: timestamp,
          title: name,
        ));
  }




  



  reloadData (){
    setState(() {
      _isLoading = true;
      _lastVisible = null;
      _snap.clear();
      _data.clear();
    });
    _getData();
  }


  openFeaturedDialog (String timestamp) {
    final AdminBloc ab = Provider.of<AdminBloc>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(50),
            elevation: 0,
            children: <Widget>[
              Text('Remove from Featured',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900)),
              SizedBox(
                height: 10,
              ),
              Text('Do you want to remove this item from the featured list?',
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Row(
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.redAccent,
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () async {
                      if (ab.userType == 'tester') {
                        Navigator.pop(context);
                        openDialog(context, 'You are a Tester', 'Only admin can do this');
                      } else {
                        await context.read<AdminBloc>().removefromFeaturedList(context, timestamp);
                        reloadData();
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.deepPurpleAccent,
                    child: Text(
                      'No',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ))
            ],
          );
        });
  }



  




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Featured Places',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 10),
          height: 3,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(15)),
        ),
        Expanded(
          child: RefreshIndicator(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 30, bottom: 20),
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: _data.length + 1,
              itemBuilder: (_, int index) {
                if (index < _data.length) {
                  return dataList(_data[index]);
                }
                return Center(
                  child: new Opacity(
                    opacity: _isLoading ? 1.0 : 0.0,
                    child: new SizedBox(
                        width: 32.0,
                        height: 32.0,
                        child: new CircularProgressIndicator()),
                  ),
                );
              },
            ),
            onRefresh: () async {
              reloadData();
            },
          ),
        ),
      ],
    );
  }




  Widget dataList(Place d) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 165,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),),
            child: CustomCacheImage(imageUrl: d.imageUrl1, radius: 10,),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        d.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(LineIcons.map_marker, size: 15, color: Colors.grey),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        d.location,
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.access_time, size: 15, color: Colors.grey),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        d.date,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Text(
                              d.loves.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          height: 35,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.comment,
                            size: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        onTap: () {
                          navigateToReviewPage(context, d.timestamp, d.name);
                        },
                      ),
                      
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                            height: 35,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.edit,
                                size: 16, color: Colors.grey[800])),
                        onTap: () {
                          nextScreen(context, UpdatePlace(placeData: d));
                        },
                      ),
                      SizedBox(width: 10),

                      Container(
                        height: 35,
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(30)),
                        child: FlatButton.icon(
                            onPressed: () => openFeaturedDialog(d.timestamp),
                            icon: Icon(LineIcons.close),
                            label: Text('Remove from featured')),
                      ),
                      
                      
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
