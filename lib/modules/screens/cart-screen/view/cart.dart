import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../utils/firestore_helper.dart';

class CartProduct extends StatefulWidget {
  final Map<String, dynamic> cartProduct;

  const CartProduct({Key? key, required this.cartProduct}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
      log(quantity.toString());
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        log(quantity.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      height: height / 5.5,
      width: width / 1.2,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.cartProduct['image'],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(widget.cartProduct['name']),
                  ),
                  Expanded(
                    child: Text("${widget.cartProduct['price']}"),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            decrementQuantity();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            height: height * 0.025,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 16,
                            ),
                          ),
                        ),
                        Text("$quantity"),
                        GestureDetector(
                          onTap: () {
                            incrementQuantity();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            height: height * 0.025,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: height * 0.05,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  Stream<QuerySnapshot<Map<String, dynamic>>> _fetchCartProducts() {
    return FireStoreHelper.fireStoreHelper.fetchCartProdutcs();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> cart = [];
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _fetchCartProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            cart = snapshot.data!.docs;
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox(
                  height: height * 0.8, // Adjust height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> cartProduct = cart[index].data();
                      // Check if 'name' field exists
                      if (cartProduct.containsKey('name')) {
                        return CartProduct(cartProduct: cartProduct);
                      } else {
                        // 'name' field does not exist
                        return Container(
                          height: height / 4, // Adjust height as needed
                          width: width / 1.2, // Adjust width as needed
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: const Center(
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
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
