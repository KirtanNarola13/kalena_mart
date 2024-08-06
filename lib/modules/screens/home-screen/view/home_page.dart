//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kalena_mart/utils/firestore_helper.dart';
// import 'package:kalena_mart/constants/string.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final TextEditingController searchController = TextEditingController();
//   List _allResult = [];
//   List _resultList = [];
//
//   getAllProducts() async {
//     var data = await FirebaseFirestore.instance.collection('products').get();
//     setState(() {
//       _allResult = data.docs;
//     });
//     searchResultList();
//   }
//
//   @override
//   void initState() {
//     searchController.addListener(_onSearchChanged);
//     super.initState();
//   }
//
//   _onSearchChanged() {
//     searchResultList();
//   }
//
//   searchResultList() {
//     var showResult = [];
//     if (searchController.text != "") {
//       for (var productSnapshot in _allResult) {
//         var name = productSnapshot['name'].toString().toLowerCase();
//         if (name.contains(searchController.text.toLowerCase())) {
//           showResult.add(productSnapshot);
//         }
//       }
//     } else {
//       showResult = List.from(_allResult);
//     }
//
//     setState(() {
//       _resultList = showResult;
//     });
//   }
//
//   @override
//   void dispose() {
//     searchController.removeListener(_onSearchChanged);
//     super.dispose();
//   }
//
//   @override
//   void didChangeDependencies() {
//     getAllProducts();
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     return SafeArea(
//       child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//         stream: FireStoreHelper.fireStoreHelper.fetchAddress(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Text("Something went wrong!");
//           } else if (snapshot.hasData) {
//             DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
//             Map<String, dynamic> user = data?.data() ?? {};
//             userAddress = user['address'] ?? '';
//             userEmail = user['email'] ?? '';
//             userNumber = user['number'];
//             return Scaffold(
//               backgroundColor: Colors.white,
//               appBar: AppBar(
//                 elevation: 1,
//                 toolbarHeight: height / 12,
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   ),
//                 ),
//                 backgroundColor: Colors.grey.shade200.withOpacity(0.3),
//                 title: const Text(
//                   "KALENA MART",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     letterSpacing: 5,
//                   ),
//                 ),
//                 centerTitle: true,
//               ),
//               body: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: height / 50),
//                     Center(
//                       child: Container(
//                         padding: EdgeInsets.only(left: 10),
//                         margin: EdgeInsets.only(bottom: 5),
//                         height: height / 16,
//                         width: width / 1.2,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(40),
//                           border: Border.all(
//                             color: Colors.grey.shade700,
//                             width: 1,
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.search_outlined,
//                               color: Colors.grey.shade700,
//                             ),
//                             SizedBox(width: width / 35),
//                             Container(
//                               alignment: Alignment.center,
//                               width: width / 1.5,
//                               child: TextFormField(
//                                 controller: searchController,
//                                 decoration: InputDecoration(
//                                   hintText: 'Search product',
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: height * 0.7,
//                       child: ListView.builder(
//                         itemCount: _resultList.length,
//                         itemBuilder: (context, i) {
//                           var productData = _resultList[i];
//                           return GestureDetector(
//                             onTap: () {
//                               Get.toNamed('/detail', arguments: [
//                                 productData['image'],
//                                 productData['name'],
//                                 productData['price'],
//                                 productData['mrp'],
//                                 productData['category'],
//                                 productData['description'],
//                               ]);
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.only(
//                                   left: 20, bottom: 10, right: 20),
//                               width: width * 0.9,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   bottomRight: Radius.circular(20),
//                                 ),
//                                 border: Border.all(
//                                   color: Colors.grey,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     margin: EdgeInsets.all(10),
//                                     height: height * 0.25,
//                                     decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                       ),
//                                       image: DecorationImage(
//                                         image: NetworkImage(
//                                           productData['image'],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: height * 0.02),
//                                   Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           productData['name'],
//                                           style: TextStyle(
//                                             color: Colors.grey.shade700,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         Text(
//                                           productData['description'],
//                                           style: TextStyle(
//                                             color: Colors.grey.shade700,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               "₹ ${productData['price']}",
//                                               style: TextStyle(
//                                                 color: Colors.grey.shade700,
//                                               ),
//                                             ),
//                                             Text(
//                                               "${productData['mrp']}",
//                                               style: const TextStyle(
//                                                 color: Colors.grey,
//                                                 fontSize: 12,
//                                                 decoration:
//                                                     TextDecoration.lineThrough,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  List _allResult = [];
  List _resultList = [];
  String selectedCategory = 'All'; // Add a variable for selected category

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllCategories() async {
    // Fetch categories from Firestore
    var data = await FirebaseFirestore.instance.collection('category').get();
    return data.docs;
  }

  Future<void> getAllProducts() async {
    // Fetch products from Firestore
    var data = await FirebaseFirestore.instance.collection('products').get();
    setState(
      () {
        _allResult = data.docs;
      },
    );
    searchResultList();
  }

  @override
  void initState() {
    searchController.addListener(_onSearchChanged);
    super.initState();
  }

  void _onSearchChanged() {
    searchResultList();
  }

  void searchResultList() {
    var showResult = [];
    if (searchController.text != "") {
      for (var productSnapshot in _allResult) {
        var name = productSnapshot['name'].toString().toLowerCase();
        if (name.contains(searchController.text.toLowerCase())) {
          if (selectedCategory == 'All' ||
              productSnapshot['category'] == selectedCategory) {
            showResult.add(productSnapshot);
          }
        }
      }
    } else {
      showResult = List.from(_allResult);
      if (selectedCategory != 'All') {
        showResult = showResult
            .where((product) => product['category'] == selectedCategory)
            .toList();
      }
    }

    setState(() {
      _resultList = showResult;
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getAllProducts();
    super.didChangeDependencies();
  }

  Future<void> _selectCategory() async {
    var categories = await getAllCategories();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Category',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...categories.map(
                (category) {
                  return ListTile(
                    title: Text(
                      category['name'],
                    ),
                    onTap: () {
                      setState(
                        () {
                          selectedCategory = category['name'];
                          Navigator.of(context).pop();
                        },
                      );
                      searchResultList(); // Update the list based on selected category
                    },
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'All',
                ),
                onTap: () {
                  setState(
                    () {
                      selectedCategory = 'All';
                      Navigator.of(context).pop();
                    },
                  );
                  searchResultList(); // Show all products
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
          actions: [
            IconButton(
              icon: const Icon(Icons.category),
              onPressed: _selectCategory,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 50),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  height: height / 16,
                  width: width / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.grey.shade700,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_outlined,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(width: width / 35),
                      Container(
                        alignment: Alignment.center,
                        width: width / 1.5,
                        child: TextFormField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search product',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.7,
                child: ListView.builder(
                  itemCount: _resultList.length,
                  itemBuilder: (context, i) {
                    var productData = _resultList[i];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/detail', arguments: [
                          productData['image'],
                          productData['name'],
                          productData['price'],
                          productData['mrp'],
                          productData['description'],
                        ]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          bottom: 10,
                          right: 20,
                        ),
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                              20,
                            ),
                            bottomRight: Radius.circular(
                              20,
                            ),
                          ),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(
                                10,
                              ),
                              height: height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    20,
                                  ),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    productData['image'],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                10,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productData['name'],
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    productData['description'],
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
        ),
      ),
    );
  }
}
