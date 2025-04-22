import 'package:exp/app_screens/details_screen.dart';
import 'package:exp/model_classes/category_list.dart';
import 'package:exp/model_classes/items_list.dart';
import 'package:exp/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exp/provider/stock_provider.dart';
import 'package:provider/provider.dart';

class Inventory extends StatefulWidget {
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  List<item_model_class> filterList = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    final stockProvider = Provider.of<StockProvider>(context, listen: false);

    stockProvider.fetchData().then((_) {
      if (stockProvider.list.isEmpty) {
        stockProvider.loadInitialStock(show_stock); // Load initial data
      }
    });
  }

  final categoryList = category_list;

  void filter(int index) {
    final stockProvider = Provider.of<StockProvider>(context, listen: false);
    final stock = stockProvider.list;
    final selected = categoryList[index].name;

    setState(() {
      if (selectedCategory == selected) {
        selectedCategory = null;
        filterList = [];
      } else {
        selectedCategory = selected;
        filterList = stock
            .where((product) =>
        product.category.toLowerCase() == selected.toLowerCase())
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(viewportFraction: 0.70);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // Header row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 2,
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: Container(
                      width: 70,
                      height: 70,
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: const [
                      Text(
                        "T A Y L O R ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        " S H A W N ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Material(
                        elevation: 2,
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(color: const Color(0xFFF8F8F8)),
                          ),
                          child: const Center(
                            child: FaIcon(FontAwesomeIcons.bagShopping, color: Colors.black, size: 24),
                          ),
                        ),
                      ),
                      // Counter badge
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Consumer<cart_provider>(
                          builder: (context, cart, _) {
                            return cart.getallitems().isNotEmpty
                                ? Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${cart.getallitems().length}",
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            )
                                : const SizedBox();
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Banner
            Container(
              width: 380,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.asset(
                  "assets/images/canva.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Category list
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final item = categoryList[index];
                  final isSelected =
                      selectedCategory == categoryList[index].name;

                  return GestureDetector(
                    onTap: () {
                      filter(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 3)
                              : null,
                          image: DecorationImage(
                            image: AssetImage(item.image),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 1,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 40,
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/images/new1.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Grid
            SizedBox(
              child: Consumer<StockProvider>(
                builder: (context, stockProvider, child) {
                  final products =
                  filterList.isEmpty ? stockProvider.list : filterList;

                  if (products.isEmpty) {
                    return const Center(
                      child: Text("No products available"),
                    );
                  }

                  return SizedBox(
                    height: 420,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            double value = 1.0;
                            if (controller.position.haveDimensions) {
                              value = controller.page! - index;
                              value = (1 - (value.abs() * 0.3))
                                  .clamp(0.0, 1.0);
                            }
                            return Center(
                              child: Transform.scale(
                                scale: Curves.easeOut.transform(value),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => details(index: products[index])

                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 340,
                                    height: 400,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.shade300,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 15,
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Hero(
                                        tag: products[index].image,
                                        child: Image.asset(
                                          products[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
