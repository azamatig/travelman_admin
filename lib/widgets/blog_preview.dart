import 'package:admin/utils/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';




Future showBlogPreview(context, String title, String description, String thumbnailUrl, int loves, String source, String date) async {
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
                  child: CustomCacheImage(imageUrl: thumbnailUrl, radius: 0.0)
                      //Image(fit: BoxFit.cover, image: NetworkImage(thumbnailUrl)),
                ),

                Positioned(
                  top: 10,
                  right: 20,
                  child: CircleAvatar(
                    child: IconButton(icon: Icon(Icons.close), onPressed:() => Navigator.pop(context) ),
                  ),
                )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                

                
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        FlatButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          color: Colors.grey[200],
                          onPressed: ()async{
                            await launch(source);
                          }, 
                          icon: Icon(Icons.link, color: Colors.grey[900],), 
                          label: Text('Source Url', style: TextStyle(color: Colors.grey[900]),)
                        )
                      ],
                    ),

                    SizedBox(height: 20,),

                    Text(
                    title,
                    style: TextStyle(
                        fontSize: 25,
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
                      Icon(Icons.favorite, size: 16, color: Colors.grey),
                      Text(loves.toString(), style: TextStyle(color: Colors.grey, fontSize: 13),),
                      SizedBox(width: 15,),
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      Text(date, style: TextStyle(color: Colors.grey, fontSize: 13),),
                      

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
                      data: '''$description''',
                      onLinkTap: (url)async{
                        await launch(url);

                      },
                      onImageTap: (url)async{
                        await launch(url);

                      },
                      
                      
                  ),


                  ],
                  ),
                ),
                SizedBox(height: 20,),
                
              ],
            ),
          ),
        );
      });
}
