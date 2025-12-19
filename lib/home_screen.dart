// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key, required this.loggedUser});
  final String loggedUser;

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Open Fashion",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontFamily: "TenorSans",
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              /* ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    prefs.getKeys().length.toString(),
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
                  ),
                ),
              );*/
              await prefs.remove("loggedIn");
              await prefs.remove("loggedInUser");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Logged Out",
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
                  ),
                ),
              );
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(children: [Icon(Icons.logout), Text("Logout")]),
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(96, 255, 255, 255),
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    circleProfiles(
                      "https://www.placeholderimage.online/images/professional/best-profile-picture.jpg",
                    ),
                    SizedBox(width: 10),
                    circleProfiles(
                      "https://www.placeholderimage.online/images/professional/profile-pic.jpg",
                    ),
                    SizedBox(width: 10),
                    circleProfiles(
                      "https://www.placeholderimage.online/images/professional/profile-photo.jpg",
                    ),
                    SizedBox(width: 10),
                    circleProfiles(
                      "https://www.placeholderimage.online/images/professional/beautiful-profile-pictures.jpg",
                    ),
                    SizedBox(width: 10),
                    circleProfiles(
                      "https://www.placeholderimage.online/images/professional/good-picture-for-profile.jpg",
                    ),
                  ],
                ),
              ),
              //Heading details
            ),

            // SizedBox(height: 10),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Save Contact",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(10)),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Meet the team",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ), //buttons list

            Container(
              //Biodata
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // open bottom sheet
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 300,
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.facebook, size: 50),
                          SizedBox(width: 20),
                          Text(
                            "   Facebook",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.chat_bubble, size: 50),
                          SizedBox(width: 20),
                          Text(
                            "Whatsapp",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.email, size: 50),
                          SizedBox(width: 20),
                          Text(
                            "Gmail",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Share',
        child: const Icon(Icons.share),
      ),
    );
  }

  Row circleProfiles(String profileImageLink) {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(profileImageLink),
          backgroundColor: Colors.grey, // Fallback color if image loads slowly
        ),
      ],
    );
  }
}

class SocialMediaContainer extends StatelessWidget {
  final String url;

  const SocialMediaContainer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Image.network(url, height: 40, width: 40, fit: BoxFit.cover),
    );
  }
}
