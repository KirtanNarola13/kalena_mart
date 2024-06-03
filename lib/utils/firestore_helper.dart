import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kalena_mart/utils/model/cart_modal.dart';
import 'package:kalena_mart/utils/model/product_model.dart';

import 'auth-helper.dart';

class FireStoreHelper {
  //singleTurn
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //AddUser

  Future<void> addUser() async {
    log("Execute");
    await firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .set({
      'name': (AuthHelper.auth.currentUser?.displayName == null)
          ? "${AuthHelper.auth.currentUser?.email?.split("@")[0].capitalizeFirst}"
          : "${AuthHelper.auth.currentUser?.displayName}",
      'email': "${AuthHelper.auth.currentUser?.email}",
      'uid': "${AuthHelper.auth.currentUser?.uid}",
      'dp': (AuthHelper.auth.currentUser?.photoURL == null)
          ? "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png"
          : AuthHelper.auth.currentUser?.photoURL,
    });
    log("User Added");
  }

  Future<void> setupAddress(
      {required String email,
      required String number,
      required String address}) async {
    return firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .set({
      'name': (AuthHelper.auth.currentUser?.displayName == null)
          ? "${AuthHelper.auth.currentUser?.email?.split("@")[0].capitalizeFirst}"
          : "${AuthHelper.auth.currentUser?.displayName}",
      'email': "${AuthHelper.auth.currentUser?.email}",
      'uid': "${AuthHelper.auth.currentUser?.uid}",
      'dp': (AuthHelper.auth.currentUser?.photoURL == null)
          ? "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png"
          : AuthHelper.auth.currentUser?.photoURL,
      'number': number,
      'address': address,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProducts() {
    return firestore.collection('products').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchOrders() {
    return firestore.collection('orders').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchorders() {
    return firestore.collection('orders').snapshots();
  }

  Future<void> cartProduct(CartModal cartModal) async {
    await firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .collection('cart')
        .add({
      'name': cartModal.name,
      'price': cartModal.price,
      'mrp': cartModal.mrp,
      'image': cartModal.image,
      'description': cartModal.description,
      'quantity': 1
    });
    log("product added to cart");
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCartProdutcs() {
    return firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .collection('cart')
        .snapshots();
  }

  Future<void> removeCartProdcut(String uid) async {
    await firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .collection('cart')
        .doc(uid)
        .delete();
  }

  Future<void> clearCart(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> cartSnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      WriteBatch batch = firestore.batch();
      cartSnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      await batch.commit();
    } catch (error) {
      print("Error clearing cart: $error");
      throw error;
    }
  }

  Future<void> createOrder(
      String userId, List<Map<String, dynamic>> cartProducts) async {
    CollectionReference orders = firestore.collection('orders');
    await orders.add({'userId': userId, 'products': cartProducts});
  }
}
