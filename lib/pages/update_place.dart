import 'package:admin/blocs/admin_bloc.dart';
import 'package:admin/models/place.dart';
import 'package:admin/utils/dialog.dart';
import 'package:admin/utils/snacbar.dart';
import 'package:admin/utils/styles.dart';
import 'package:admin/utils/toast.dart';
import 'package:admin/widgets/cover_widget.dart';
import 'package:admin/widgets/place_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePlace extends StatefulWidget {

  final Place placeData;
  UpdatePlace({Key key, @required this.placeData}) : super(key: key);

  @override
  _UpdatePlaceState createState() => _UpdatePlaceState();
}

class _UpdatePlaceState extends State<UpdatePlace> {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final String collectionName = 'places';
  List paths =[];
  String _helperText = 'Enter paths list to help users to go to the desired destination like : Dhaka to Sylhet by Bus - 200Tk.....';
  bool uploadStarted = false;
  var stateSelection;
  
  var nameCtrl = TextEditingController();
  var locationCtrl = TextEditingController();
  var descriptionCtrl = TextEditingController();
  var image1Ctrl = TextEditingController();
  var image2Ctrl = TextEditingController();
  var image3Ctrl = TextEditingController();
  var latCtrl = TextEditingController();
  var lngCtrl = TextEditingController();


  var startpointNameCtrl = TextEditingController();
  var endpointNameCtrl = TextEditingController();
  var priceCtrl = TextEditingController();
  var startpointLatCtrl = TextEditingController();
  var startpointLngCtrl = TextEditingController();
  var endpointLatCtrl = TextEditingController();
  var endpointLngCtrl = TextEditingController();
  var pathsCtrl = TextEditingController();



  clearFields(){
    nameCtrl.clear();
    locationCtrl.clear();
    descriptionCtrl.clear();
    image1Ctrl.clear();
    image2Ctrl.clear();
    image3Ctrl.clear();
    latCtrl.clear();
    lngCtrl.clear();
    startpointNameCtrl.clear();
    endpointNameCtrl.clear();
    priceCtrl.clear();
    startpointLatCtrl.clear();
    startpointLngCtrl.clear();
    endpointLatCtrl.clear();
    endpointLngCtrl.clear();
    pathsCtrl.clear();
    paths.clear();
    FocusScope.of(context).unfocus();
  }
  

  
  
  
  




  void handleSubmit() async {
    final AdminBloc ab = Provider.of<AdminBloc>(context, listen: false);
    if(stateSelection == null){
      openDialog(context, 'Select City First', '');
    }else{
      if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if(paths.length == 0){
        openSnacbar(scaffoldKey, 'Paths List can not be empty');
      } else {
        if (ab.userType == 'tester') {
        openDialog(context, 'You are a Tester', 'Only Admin can upload, delete & modify contents');
      } else {
        setState(()=> uploadStarted = true);
        await saveToDatabase();
        setState(()=> uploadStarted = false);
        openDialog(context, 'Updated Successfully', '');
        //clearFields();
      }
      }
      
    }
    }

    
  }





  Future saveToDatabase() async {
    final DocumentReference ref = firestore.collection(collectionName).doc(widget.placeData.timestamp);
    final DocumentReference ref1 = firestore.collection(collectionName).doc(widget.placeData.timestamp).collection('travel guide').doc(widget.placeData.timestamp);
    

    var _placeData = {
      'state' : stateSelection,
      'place name' : nameCtrl.text,
      'location' : locationCtrl.text,
      'latitude' : double.parse(latCtrl.text),
      'longitude' : double.parse(lngCtrl.text),
      'description' : descriptionCtrl.text,
      'image-1' : image1Ctrl.text,
      'image-2' : image2Ctrl.text,
      'image-3' : image3Ctrl.text,
    };

    var _guideData  = {
      'startpoint name' : startpointNameCtrl.text,
      'endpoint name' : endpointNameCtrl.text,
      'startpoint lat' : double.parse(startpointLatCtrl.text),
      'startpoint lng' : double.parse(startpointLngCtrl.text),
      'endpoint lat' : double.parse(endpointLatCtrl.text),
      'endpoint lng' : double.parse(endpointLngCtrl.text),
      'price': priceCtrl.text,
      'paths' : paths
    };

    await ref.update(_placeData)
    .then((value) => ref1.update(_guideData));
  }


  
  
  
  Future getGuideData () async {
    firestore.collection(collectionName).doc(widget.placeData.timestamp).collection('travel guide').doc(widget.placeData.timestamp).get().then((DocumentSnapshot snap){
      var x = snap.data();
      startpointNameCtrl.text = x['startpoint name'];
      endpointNameCtrl.text = x['endpoint name'];
      startpointLatCtrl.text = x['startpoint lat'].toString();
      startpointLngCtrl.text = x['startpoint lng'].toString();
      endpointLatCtrl.text = x['endpoint lat'].toString();
      endpointLngCtrl.text = x['endpoint lng'].toString();
      priceCtrl.text = x['price'];
      setState(() {
        paths = x['paths'];
      });
    });

  }




  initData (){
    stateSelection = widget.placeData.state;
    nameCtrl.text = widget.placeData.name;
    locationCtrl.text = widget.placeData.location;
    descriptionCtrl.text = widget.placeData.description;
    image1Ctrl.text = widget.placeData.imageUrl1;
    image2Ctrl.text = widget.placeData.imageUrl2;
    image3Ctrl.text = widget.placeData.imageUrl3;
    latCtrl.text = widget.placeData.latitude.toString();
    lngCtrl.text = widget.placeData.longitude.toString();
    getGuideData();
  }



  @override
  void initState() { 
    super.initState();
    initData();
  }
  
  




  handlePreview() async{
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if(paths.isNotEmpty){
        showPlacePreview(
          context, 
          nameCtrl.text, 
          locationCtrl.text, 
          image1Ctrl.text, 
          descriptionCtrl.text, 
          double.parse(latCtrl.text), 
          double.parse(lngCtrl.text), 
          startpointNameCtrl.text, 
          endpointNameCtrl.text, 
          double.parse(startpointLatCtrl.text), 
          double.parse(startpointLngCtrl.text),
          double.parse(endpointLatCtrl.text),
          double.parse(endpointLngCtrl.text),
          priceCtrl.text,
          paths
        );
      }else{
        openToast(context, 'Path List is Empty!');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[200],
      key: scaffoldKey,
      body: CoverWidget(
              widget: Form(
              key: formKey,
              child: ListView(children: <Widget>[
                SizedBox(height: h * 0.10,),
                Text('Place Details', style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.w800
                ),),
                SizedBox(height: 20,),
                statesDropdown(),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: inputDecoration('Enter place name', 'Place name', nameCtrl),
                  controller: nameCtrl,
                  validator: (value){
                    if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: inputDecoration('Enter location name', 'Location name', locationCtrl),
                  controller: locationCtrl,
                  
                  validator: (value){
                    if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                

                Row(
                  children: <Widget>[
                    Expanded(
                  child: TextFormField(
                  decoration: inputDecoration('Enter Latitude', 'Latitude', latCtrl),
                  controller: latCtrl,
                  keyboardType: TextInputType.number,
                  validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
              ),
                SizedBox(width: 10,),
                Expanded(
                              child: TextFormField(
                    decoration: inputDecoration('Enter Longitude', 'Longitude', lngCtrl),
                    keyboardType: TextInputType.number,

                    controller: lngCtrl,
                    validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                    },
                    
                  ),
                ),
                
                  ],
                ),
                SizedBox(height: 20,),


                TextFormField(
                  decoration: inputDecoration('Enter image url (thumbnail)', 'Image1(Thumbnail)', image1Ctrl),
                  controller: image1Ctrl,
                  validator: (value){
                    if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: inputDecoration('Enter image url', 'Image2', image2Ctrl),
                  controller: image2Ctrl,
                  validator: (value){
                    if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: inputDecoration('Enter image url', 'Image3', image3Ctrl),
                  controller: image3Ctrl,
                  validator: (value){
                    if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter place details (Html or Normal Text)',
                    border: OutlineInputBorder(),
                    labelText: 'Place details',
                    contentPadding: EdgeInsets.only(right: 0, left: 10, top: 15, bottom: 5),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey[300],
                        child: IconButton(icon: Icon(Icons.close, size: 15), onPressed: (){
                          descriptionCtrl.clear();
                        }),
                      ),
                    )
                    
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  minLines: 5,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: descriptionCtrl,
                  validator: (value){
                    if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                SizedBox(height: 50,),
                Text('Travel Guide Details', style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.w800
                ),),
                SizedBox(height: 20,),


                Row(
                  children: <Widget>[
                    Expanded(
                                      child: TextFormField(
                  decoration: inputDecoration('Enter startpont name', 'Startpont name', startpointNameCtrl),
                  controller: startpointNameCtrl,
                  
                  validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                    ),
                SizedBox(width: 10,),
                Expanded(
                              child: TextFormField(
                    decoration: inputDecoration('Enter endpoint name', 'Endpoint name', endpointNameCtrl),
                    

                    controller: endpointNameCtrl,
                    validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                    },
                    
                  ),
                ),
                
                  ],
                ),

                SizedBox(height: 20,),
                TextFormField(
                    decoration: inputDecoration('Enter travel cost', 'Price', priceCtrl),
                    keyboardType: TextInputType.number,

                    controller: priceCtrl,
                    validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                    },
                    
                  ),
                SizedBox(height: 20,),

                Row(
                  children: <Widget>[
                    Expanded(
                                      child: TextFormField(
                  decoration: inputDecoration('Enter startpoint latitude', 'Startpoint latitude', startpointLatCtrl),
                  controller: startpointLatCtrl,
                  keyboardType: TextInputType.number,
                  validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                    ),
                SizedBox(width: 10,),
                Expanded(
                              child: TextFormField(
                    decoration: inputDecoration('Enter startpoint longitude', 'Startpoint longitude', startpointLngCtrl),
                    keyboardType: TextInputType.number,

                    controller: startpointLngCtrl,
                    validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                    },
                    
                  ),
                ),
                
                  ],
                ),
                SizedBox(height: 20,),

                Row(
                  children: <Widget>[
                    Expanded(
                                      child: TextFormField(
                  decoration: inputDecoration('Enter endpoint latitude', 'Endpoint latitude', endpointLatCtrl),
                  controller: endpointLatCtrl,
                  keyboardType: TextInputType.number,
                  validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                  },
                  
                ),
                    ),
                SizedBox(width: 10,),
                Expanded(
                    child: TextFormField(
                    decoration: inputDecoration('Enter endpoint longitude', 'Endpoint longitude', endpointLngCtrl),
                    keyboardType: TextInputType.number,

                    controller: endpointLngCtrl,
                    validator: (value){
                      if(value.isEmpty) return 'Value is empty'; return null;
                    },
                    
                  ),
                ),
                
                  ],
                ),
                SizedBox(height: 20,),

                TextFormField(
                    
                    decoration: InputDecoration(
                    hintText: "Enter path list one by one by tapping 'Enter' everytime",
                    border: OutlineInputBorder(),
                    labelText: 'Paths list',
                    helperText: _helperText,
                    contentPadding: EdgeInsets.only(right: 0, left: 10, top: 15, bottom: 5),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey[300],
                        child: IconButton(icon: Icon(Icons.clear, size: 15, color: Colors.blueAccent,), onPressed: (){
                          pathsCtrl.clear();
                        }),
                      ),
                    )
                    
                  ),
                    controller: pathsCtrl,
                    
                    onFieldSubmitted: (String value) {
                      if(value.length == 0){
                        setState(() {
                        _helperText = "You can't put empty item is the list";
                          
                        });
                      } else{
                        setState(() {
                        paths.add(value);
                        _helperText = 'Added ${paths.length} items';
                        print(paths);
                      });
                      }
                      
                    },
                  ),

                SizedBox(height: 20,),
                Container(
                  
                  child: paths.length == 0 ? Center(child: Text('No path list were added'),) :
                  
                  ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: paths.length,
                        itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(index.toString()),
                          ),
                          title: Text(paths[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline), 
                            onPressed: (){
                              setState(() {
                                paths.remove(paths[index]);
                                _helperText = 'Added ${paths.length} items';

                              });
                            }),
                        );
                       },
                      ),
                  
                  
                ),


                SizedBox(height: 100,),


                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton.icon(
                            
                            icon: Icon(Icons.remove_red_eye, size: 25, color: Colors.blueAccent,),
                            label: Text('Preview', style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                            ),),
                            onPressed: (){
                              handlePreview();
                            }
                          )
                        ],
                      ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      color: Colors.deepPurpleAccent,
                      height: 45,
                      child: uploadStarted == true
                        ? Center(child: Container(height: 30, width: 30,child: CircularProgressIndicator()),)
                        : FlatButton(
                          child: Text(
                            'Update Place Data',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () async{
                            handleSubmit();
                            
                          })
                        
                        ),
                  SizedBox(
                    height: 200,
                  ),
                
                

              ],)),
      ),
      );
        
   }



   Widget statesDropdown() {
    final AdminBloc ab = Provider.of(context, listen: false);
    return Container(
        height: 50,
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[300]),
            borderRadius: BorderRadius.circular(30)),
        child: DropdownButtonFormField(
            itemHeight: 50,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(border: InputBorder.none),
            onChanged: (value) {
              setState(() {
                stateSelection = value;
              });
            },
            onSaved: (value) {
              setState(() {
                stateSelection = value;
              });
            },
            value: stateSelection,
            hint: Text('Select State'),
            items: ab.states.map((f) {
              return DropdownMenuItem(
                child: Text(f),
                value: f,
              );
            }).toList()));
  }

}
