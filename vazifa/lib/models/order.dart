class Orders {
  String title;
  double price;
  String imageUrl;
  int count;
  Orders({
    required this.count,
    required this.imageUrl,
    required this.price,
    required this.title,
  });

  factory Orders.fromJson(Map orders) {
    return Orders(
      imageUrl: orders['imageUrl'],
      title: orders['title'],
      count: orders['count'] as int,
      price: orders['price'] as double,
    );
  }
}
