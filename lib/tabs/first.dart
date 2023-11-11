import 'package:assignment/constant/color.dart';
import 'package:assignment/constant/image.dart';
import 'package:assignment/models/datamodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> images = [beardTrim, hairstraight, makeupimage];
Widget curoselSlider = CarouselSlider(
  options: CarouselOptions(height: 200.0, autoPlay: true),
  items: images.map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              fit: BoxFit.fitHeight,
              width: MediaQuery.of(context).size.width,
              height: 100,
              image: AssetImage(i),
            ),
          ),
        );
      },
    );
  }).toList(),
);

class First extends StatelessWidget {
  First({super.key});
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<DataModel>>(
          stream: readData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return SizedBox(
                height: 1500,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 1500,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: const Image(
                              fit: BoxFit.fill,
                              image: AssetImage(dp),
                            ),
                          ),
                          title: Text(
                            'Good Morning',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                                color: grey),
                          ),
                          subtitle: Text(
                            'Sushma Sukhla',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: black),
                          ),
                          trailing: const SizedBox(
                              width: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.notifications_none),
                                  Icon(Icons.favorite_outline),
                                ],
                              )),
                        ),
                        search,
                        const SizedBox(height: 10.0),
                        curoselSlider,
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Featured Services',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.more_horiz_outlined,
                              color: darkBlue,
                            )
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              features(
                                  image: beardTrim,
                                  name: "Beard Trimming",
                                  real: "200",
                                  cross: "300"),
                              const SizedBox(width: 20.0),
                              features(
                                  image: hairstraight,
                                  name: "Hair Straightener",
                                  real: "1,00",
                                  cross: "2,100"),
                              const SizedBox(width: 20.0),
                              features(
                                  image: makeupimage,
                                  name: "Makeup",
                                  real: "1,000",
                                  cross: "2,000"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Category',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'View All',
                              style: TextStyle(
                                  color: darkBlue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            category(haircut, "Hair Cut"),
                            category(makeup, "Makeup"),
                            category(straight, "Straightening"),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            category(nail, "Mani-pedi"),
                            category(spa, "Spa/Message"),
                            category(beard, "Beard"),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        const Text(
                          'Most Popular Services',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Chip(
                                backgroundColor: lightBlue,
                                label: const Text("All")),
                            Chip(
                                backgroundColor: lightBlue,
                                label: const Text("Haircuts")),
                            Chip(
                                backgroundColor: lightBlue,
                                label: const Text("Make up")),
                            Chip(
                                backgroundColor: lightBlue,
                                label: const Text("Manicure"))
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: data.map(buildTile).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildTile(DataModel dataModel) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                height: 100,
                width: 120,
                fit: BoxFit.cover,
                image: NetworkImage(dataModel.image!),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dataModel.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      Icon(
                        dataModel.fav == true
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: red,
                      )
                    ],
                  ),
                ),
                Text(
                  dataModel.location!,
                  style: TextStyle(
                      color: grey, fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: darkBlue,
                    ),
                    Text(dataModel.distance.toString()!),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(
                        "${dataModel.rating.toString()!}\t|\t${dataModel.reviews.toString()}\tReviews"),
                  ],
                ),
              ],
            )
          ],
        ),
      );

  Stream<List<DataModel>> readData() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => DataModel.fromJson(doc.data())).toList());
}

Widget category(image, label) => SizedBox(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Image(
                height: 50,
                width: 50,
                image: AssetImage(image),
              ),
            ),
          ),
          Text(label),
        ],
      ),
    );

Widget features({image, name, real, cross}) => Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Image(
              height: 100,
              image: AssetImage(image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Text(
              name,
              style: TextStyle(color: black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  'Rs $real',
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Rs $cross',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough, color: grey),
                ),
              ],
            ),
          )
        ],
      ),
    );

Widget search = TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: white),
    ),
    hintText: 'Search',
    hintStyle: TextStyle(color: grey),
    prefixIcon: const Icon(Icons.search),
    suffixIcon: const Icon(Icons.filter_list),
  ),
);
