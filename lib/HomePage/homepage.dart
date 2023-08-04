import 'package:flutter/material.dart';
import 'package:news_app/Constants/constants.dart';
import 'package:news_app/CustomWidgets/newsPost.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String? stringResponse;
  Map mapResponse={};
  String apiKey='2b0803cd01a44287ba70029d2bd98521';

  String? source;
  String? title;
  String? imageUrl;

  List<String> fetchedTitle = [];
  List<String> fetchedSource = [];
  List<String> fetchedImage = [];

  Future apiCall() async{
    http.Response response;
    response= await http.get(Uri.parse('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=$apiKey'));
    if( response.statusCode == 200 ){
      setState(() {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);

        if (mapResponse['articles'] != null &&
            mapResponse['articles'].isNotEmpty) {
          // Extracting data from the first article in the list
          for(var item in mapResponse['articles']){
            fetchedSource.add(item['source']['name']);
            fetchedTitle.add(item['title']);
            fetchedImage.add(item['urlToImage']);
          }
          print('GET request successful, no error');
        }
       });
     }
    else {
      // API call failed, handle the error
      print('API call failed with status code: ${response.statusCode}');
    }
}

  @override
  void initState() {
    // TODO: implement initState
    apiCall();
    super.initState();
  }

@override

  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    String headline='News Headline';
    String news='Content for the respective headline';

    return Scaffold(
      backgroundColor: AppStyle.appLightBlue,
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Transform.rotate(
                angle: 45 * 3.14 / 180, // 90 degrees in radians
                child: Icon(Icons.navigation_rounded),
              ),
              Text('IN',style: AppStyle.HeaderText.copyWith(color:Colors.white)),
              SizedBox(width: 20,),
            ],
          ),
        ],
        leading: null,
        automaticallyImplyLeading: false,
        title: const Text('MyNews',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 21,
          ),
        ),
        backgroundColor: AppStyle.appBlue, //Color(0xfff5f8fd),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top Headlines',style: AppStyle.HeaderText),
                SizedBox(height: 10),
               SizedBox(
                   width: width,
                   height: height,
                   child: ListView.builder(
                     itemCount: fetchedSource.length,
                     shrinkWrap: true,
                     itemBuilder: (BuildContext context,int index){
                       return NewsPost(
                           w: width,
                           news :fetchedTitle[index],
                           headline: fetchedSource[index],
                           image: fetchedImage[index],
                       );
                     }
                   ),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
