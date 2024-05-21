import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kalena_mart/utils/firestore_helper.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/globle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Bag',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: (isBag == true && cartList.length > 0) ? true : false,
        child: FloatingActionButton.extended(
          elevation: 0,
          splashColor: Colors.grey.withOpacity(0.2),
          backgroundColor: Colors.grey.withOpacity(0.2),
          onPressed: () {
            setState(() {});
          },
          label: Text(
            "CheckOut",
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: height / 12,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.grey.shade200.withOpacity(0.3),
        title: const Text(
          "KALENA MART",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: (isHome == true) ? true : false,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 25,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                          ),
                          height: height / 16,
                          width: width / 1.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(40),
                            ),
                            border: Border.all(
                              color: Colors.grey.shade700,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.search_outlined,
                                    color: Colors.grey.shade700,
                                  ),
                                  SizedBox(
                                    width: width / 35,
                                  ),
                                  Text(
                                    "search product",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      letterSpacing: 2,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey.shade700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FireStoreHelper.fireStoreHelper.fetchProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text("No products found"),
                            );
                          } else {
                            List<QueryDocumentSnapshot<Map<String, dynamic>>>
                                products = snapshot.data!.docs;
                            return SizedBox(
                              height: height * 0.4, // Adjust height as needed
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> productData =
                                      products[index].data();
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/detail',
                                          arguments: productData);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 17, left: 5),
                                      width:
                                          width * 0.6, // Adjust width as needed
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    productData['image'],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                ),
                                                color: Colors.black12,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    productData['name'],
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "₹ ${productData['price']}",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${productData['mrp']}",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: (isFav == true) ? true : false,
                child: SingleChildScrollView(
                  child: Column(
                    children: favList
                        .map(
                          (e) => Container(
                            height: height / 5,
                            width: width / 0.9,
                            margin: const EdgeInsets.only(
                                top: 30, left: 20, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300.withOpacity(0.3),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage("${e['thumbnail']}"),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "${e['name']}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "₹ ${e['price']}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 80,
                                        ),
                                        Text(
                                          "(${e['ratingcount']})",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 9,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${e['faceprice']}",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            SizedBox(
                                              width: width / 120,
                                            ),
                                            Text(
                                              "(%${e['discount']} off)",
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 50,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                  'detail_page',
                                                  arguments: e,
                                                );
                                                setState(() {});
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: height / 30,
                                                width: width / 4,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Text(
                                                  "VIEW",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 12,
                                                    letterSpacing: 2,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                e['isLike'] = !e['isLike'];
                                                favList.remove(e);
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: height / 30,
                                                width: width / 8,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: (e['isLike'] == false)
                                                    ? const Icon(
                                                        LineIcons.heart,
                                                        size: 16,
                                                      )
                                                    : Icon(
                                                        Icons.favorite,
                                                        color: Colors.red
                                                            .withOpacity(
                                                          0.5,
                                                        ),
                                                        size: 16,
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Visibility(
                visible: (isBag == true) ? true : false,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FireStoreHelper.fireStoreHelper.fetchCartProdutcs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>> cart =
                          snapshot.data!.docs;
                      return SizedBox(
                        height: height * 0.8, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> cartProduct =
                                cart[index].data();
                            // Check if 'name' field exists
                            if (cartProduct.containsKey('name')) {
                              return Container(
                                height: height / 4, // Adjust height as needed
                                width: width / 1.2, // Adjust width as needed
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            bottomLeft: Radius.circular(25),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                cartProduct['image']),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartProduct['name'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "₹ ${cartProduct['price']}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "${cartProduct['mrp']}",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Handle remove from cart
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    width: width / 4,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "Remove",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontSize: 12,
                                                        letterSpacing: 2,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Handle favorite
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: width / 8,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.red
                                                          .withOpacity(0.5),
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // 'name' field does not exist
                              return Container(
                                height: height / 4, // Adjust height as needed
                                width: width / 1.2, // Adjust width as needed
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                  child: Text(
                                    "Product Name Not Available",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 10,
              tabActiveBorder: Border.all(
                color: Colors.black,
              ),
              activeColor: Colors.black,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textSize: 20,
              tabBackgroundColor: Colors.grey[50]!,
              color: Colors.grey.shade700.withOpacity(0.8),
              haptic: true,
              tabs: [
                GButton(
                  onPressed: () {
                    isHome = true;
                    isFav = false;
                    isBag = false;
                    isProfile = false;
                    setState(() {});
                  },
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  onPressed: () {
                    isHome = false;
                    isFav = true;
                    isBag = false;
                    isProfile = false;
                    setState(() {});
                  },
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  onPressed: () {
                    isHome = false;
                    isFav = false;
                    isBag = true;
                    isProfile = false;
                    setState(() {});
                  },
                  icon: LineIcons.shoppingBag,
                  text: 'Bag',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
