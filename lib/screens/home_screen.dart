import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:sushi_app_jhonny_mustafa/models/food.dart';
import 'package:sushi_app_jhonny_mustafa/screens/detail_food.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Food> food = [];

  Future<void> loadFoodData() async {
    String jsonData = await rootBundle.loadString('assets/json/food.json');
    List<dynamic> jsonMap = json.decode(jsonData);

    setState(() {
      food = jsonMap.map((json) => Food.fromJson(json)).toList();
    });

    print(food[0].name);
  }

  @override
  void initState() {
    // TODO: implement initState
    loadFoodData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        //backgroundColor: Colors.red,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sushiman',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 15,
                ),
                Text(
                  'Jakarta, Indonesia',
                  style: TextStyle(
                    fontSize: 15.0,
                    //  fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.cart,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            // children: [
            child: Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sushi_nigiri.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Text(
                    'Get Promo 78%\nSushi Nigiri',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: CupertinoButton(
                      color: Colors.red.withOpacity(0.8),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Redeem'),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ],
          ),

          SizedBox(
            height: 20,
          ),

          //Searchbar
          SearchBar(
            hintText: 'Search food',
            hintStyle: MaterialStatePropertyAll(TextStyle(color: Colors.grey)),
            leading: Icon(CupertinoIcons.search),
            padding:
                MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            elevation: MaterialStatePropertyAll(0),
          ),

          SizedBox(
            height: 20,
          ),

          // CupertinoButton(
          //   child: Text('load data'),
          //   onPressed: () {
          //     loadFoodData();
          //   },
          // ),

          //best seller
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'best seller',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // SizedBox(
              //   height: 200,
              //   width: 200,
              //   // decoration: BoxDecoration(
              //   //   image: DecorationImage(
              //   //     image: AssetImage(food[0].imagePath.toString()),
              //   //   ),
              //   // ),
              //   child: Image.asset(
              //     food[0].imagePath.toString(),
              //   ),
              //color: Colors.red,

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return DetailFood(
                              food: food[2],
                            );
                          },
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 200,
                                width: MediaQuery.sizeOf(context).width,
                                child: Image.asset(
                                  food[2].imagePath.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food[2].name.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  Text(
                                    //food[2].price.toString(),
                                    '${food[2].price} IDR',
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),

          //Popular food
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular food',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // SizedBox(
              //   height: 200,
              //   width: 200,
              //   // decoration: BoxDecoration(
              //   //   image: DecorationImage(
              //   //     image: AssetImage(food[0].imagePath.toString()),
              //   //   ),
              //   // ),
              //   child: Image.asset(
              //     food[0].imagePath.toString(),
              //   ),
              //color: Colors.red,

              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(right: 10),
                  itemCount: food.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return DetailFood(
                                food: food[index],
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        margin: EdgeInsets.only(
                          left: index == 0 ? 0 : 0,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              //margin: EdgeInsets.only(right: 16),
                              color: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  food[index].imagePath.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              food[index].name.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              //food[2].price.toString(),
                              '${food[index].price} IDR',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
