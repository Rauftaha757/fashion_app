import 'package:exp/app_screens/details_screen.dart';
import 'package:exp/model_classes/category_list.dart';
import 'package:exp/model_classes/items_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exp/provider/stock_provider.dart';
import 'package:provider/provider.dart';

class Inventory extends StatefulWidget {
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  void initState() {
    super.initState();
    final stockProvider = Provider.of<StockProvider>(context, listen: false);

    stockProvider.fetchData().then((_) {
      if (stockProvider.list.isEmpty) {
        stockProvider.loadInitialStock(show_stock); // this comes from your model class
      }
    });
  }
  final List<category> categoryList = [];

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(viewportFraction: 0.65);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back arrow
                  Material(
                    elevation: 2,
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),

                  // Name in the middle
                  Column(
                    children: const [
                      Text(
                        "T A Y L O R ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 26),
                      ),
                      Text(
                        " S H A W N ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 22),
                      ),
                    ],
                  ),

                  // Shopping bag icon
                  Material(
                    elevation: 2,
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: Color(0xFFF8F8F8)),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bagShopping,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Banner image
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
                itemCount: category_list.length,
                itemBuilder: (context, index) {
                  final item = category_list[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
                        child: Image.asset("assets/images/new1.jpg",fit: BoxFit.cover,)),
                    decoration: BoxDecoration(


                    ),

                  ),
                ],
              ),
            ),
            // Product grid
            Expanded(
              child: Consumer<StockProvider>(
                builder: (context, stockProvider, child) {
                  final products = stockProvider.list;

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
                              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                            }
                            return Center(
                              child: Transform.scale(
                                scale: Curves.easeOut.transform(value),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> details(index:products[index],

                                    )));
                                  },
                                  child: Container(
                                    width: 340,
                                    height: 400,
                                    margin: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.shade300,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 15,
                                          offset: Offset(0, 10),
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        products[index].image,
                                        fit: BoxFit.cover,
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
