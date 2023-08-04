import 'package:flutter/material.dart';
import 'package:news_app/Constants/constants.dart';

class NewsPost extends StatefulWidget {
  final double w;
  final String headline;
  final String news;
  final String image;

  NewsPost({required this.w,required this.headline,required this.news,required this.image});

  @override
  State<NewsPost> createState() => _NewsPostState();
}

class _NewsPostState extends State<NewsPost> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
        height: 150,
        width: widget.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                width: widget.w*0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.headline,
                        style: AppStyle.newsHeaderText,
                        overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                  Text(widget.news,
                          style: AppStyle.newsFeedText,
                          //overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),  //news feed
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: widget.w*0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.lightBlueAccent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: NetworkImage(('${widget.image}')),
                  ),
                ),
              ),
            ),  //image input
          ],
        ),
      ),
    );
  }
}
