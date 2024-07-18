import 'dart:convert';

import 'package:comments_app/core/theme/app_color.dart';
import 'package:comments_app/model/comments_modal.dart';
import 'package:comments_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// Ensure you have this import path correct

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late Future<List<CommentModel>> commentModels;

  @override
  void initState() {
    super.initState();
    commentModels = fetchCommentModels();
  }

  Future<List<CommentModel>> fetchCommentModels() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CommentModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ligthWhite,
      appBar: const CustumAppBar(
        havBackground: true,
      ),
      body: FutureBuilder<List<CommentModel>>(
        future: commentModels,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CommentModel>? data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration:  BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: AppColor.grey),
                              child: const Text("A"),
                            )),
                        Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.grey,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    SizedBox(
                                       width: MediaQuery.of(context).size.width-170,
                                      child: Text(
                                        data[index].name ?? '',
                                        style: GoogleFonts.poppins(
                                        fontWeight:FontWeight.bold
                                            ),
                                              overflow: TextOverflow.ellipsis, 
                                                maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Email: ",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.grey,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    SizedBox(

                                      width: MediaQuery.of(context).size.width-162,
                                      child: Text(data[index].email ?? '',
                                      style: GoogleFonts.poppins(
                                        fontWeight:FontWeight.bold
                                            )
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  data[index].body!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontWeight:FontWeight.w500
                                          )
                                )
                              ],
                            ))
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return  Center(child: CircularProgressIndicator(

            color: AppColor.blue,
          ));
        },
      ),
    );
  }
}
