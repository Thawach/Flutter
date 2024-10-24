import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แมวส้มมมมมม"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              future:
                  DefaultAssetBundle.of(context).loadString("assets/data.json"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No data found"));
                } else {
                  var data = json.decode(snapshot.data.toString());
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          MyBox(data[index]['title'], data[index]['subtitle'],
                              data[index]['imageUrl'], data[index]['detail']),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    },
                  );
                }
              },
            )));
  }

  Widget MyBox(String title, String subtitle, String imageUrl, String detail) {
    var v1, v2, v3, v4;

    v1 = title;
    v2 = subtitle;
    v3 = imageUrl;
    v4 = detail;

    return Container(
      padding: EdgeInsets.all(20),
      // color: const Color.fromARGB(255, 250, 181, 76),
      height: 150,
      decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 250, 181, 76),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.50), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          SizedBox(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    print("Next Page >>>>");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(v1, v2, v3, v4)));
                  },
                  child: Text(
                    "Read more...",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
