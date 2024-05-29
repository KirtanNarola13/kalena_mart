import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kalena_mart/utils/firestore_helper.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../utils/globle.dart';

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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No products found"),
                      );
                    } else {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>
                          products = snapshot.data!.docs;
                      return SizedBox(
                        height: height * 0.4, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> productData =
                                products[index].data();
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed('/detail', arguments: productData);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 17, left: 5),
                                width: width * 0.6, // Adjust width as needed
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
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
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                          ),
                                          color: Colors.black12,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productData['name'],
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "₹ ${productData['price']}",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                                Text(
                                                  "${productData['mrp']}",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    decoration: TextDecoration
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
        ));
  }
}
