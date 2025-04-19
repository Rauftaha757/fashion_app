 class item_model_class{
  String name;
  double price;
  String image;
  String category;
  item_model_class({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
 });
Map<String, dynamic> toMap(){
  return {
    'name':name,
    'price': price,
    'image': image,
    'category':category,
  };
 }
 factory item_model_class.fromMap(Map<String, dynamic> Map)=> item_model_class(
  name: Map['name'],
  price: Map['price'],
  image: Map['image'],
  category: Map['category']
  );
 }
 List<item_model_class> show_stock = [
   // Watches
   item_model_class(
     name: "Timex Classic Black Dial Watch",
     price: 4599,
     image: "assets/images/watch1.png",
     category: "Watch",
   ),
   item_model_class(
     name: "SEIKO Premier Black Leather Watch",
     price: 7999,
     image: "assets/images/watch2.png",
     category: "Watch",
   ),
   item_model_class(
     name: "Rolex Datejust Silver Dial",
     price: 15999,
     image: "assets/images/watch3.png",
     category: "Watch",
   ),
   item_model_class(
     name: "Timex Black & Silver Dual Tone Watch",
     price: 4999,
     image: "assets/images/watch4.png",
     category: "Watch",
   ),
   // Shirts
   item_model_class(
     name: "Classic White Oxford Shirt",
     price: 2499,
     image: "assets/images/shirt_1.png",
     category: "Shirt",
   ),
   item_model_class(
     name: "Plain Sky Blue Dress Shirt",
     price: 2799,
     image: "assets/images/shirt_2.png",
     category: "Shirt",
   ),
   item_model_class(
     name: "Lined Royal Blue Business Shirt",
     price: 2999,
     image: "assets/images/shirt_3.png",
     category: "Shirt",
   ),
   item_model_class(
     name: "Checked Charcoal Formal Shirt",
     price: 3199,
     image: "assets/images/shirt_4.png",
     category: "Shirt",
   ),

   // Pants
   item_model_class(
     name: "Jet Black Slim Fit Trousers",
     price: 3499,
     image: "assets/images/pant1.png",
     category: "Pant",
   ),
   item_model_class(
     name: "Navy Blue Tailored Pants",
     price: 3599,
     image: "assets/images/pant2.png",
     category: "Pant",
   ),
   item_model_class(
     name: "Classic Beige Flat-Front Pants",
     price: 3399,
     image: "assets/images/pant3.png",
     category: "Pant",
   ),
   item_model_class(
     name: "Brown Checked Formal Trousers",
     price: 3699,
     image: "assets/images/pant4.png",
     category: "Pant",
   ),

   // Suits
   item_model_class(
     name: "Light Grey Executive Suit",
     price: 8499,
     image: "assets/images/coat_1.png",
     category: "Suit",
   ),
   item_model_class(
     name: "Blue Grey Premium Suit",
     price: 8999,
     image: "assets/images/coat_2.png",
     category: "Suit",
   ),
   item_model_class(
     name: "Checked Grey Three-Piece Suit",
     price: 9499,
     image: "assets/images/coat_3.png",
     category: "Suit",
   ),
   item_model_class(
     name: "Navy Blue Formal Suit",
     price: 8999,
     image: "assets/images/coat_4.png",
     category: "Suit",
   ),



   // Shoes
   item_model_class(
     name: "Black Premium Leather Formal Shoes",
     price: 3999,
     image: "assets/images/shoes_1.png",
     category: "Shoes",
   ),
   item_model_class(
     name: "Rich Brown Furniture Leather Formals",
     price: 4299,
     image: "assets/images/shoes_2.png",
     category: "Shoes",
   ),
   item_model_class(
     name: "Polished Walnut Brown Shoes",
     price: 4499,
     image: "assets/images/shoes_4.png",
     category: "Shoes",
   ),
   item_model_class(
     name: "Chelsea Classy Brown Leather Boots",
     price: 4699,
     image: "assets/images/shoes_3.png",
     category: "Shoes",
   ),
 ];
