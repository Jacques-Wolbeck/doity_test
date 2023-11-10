class BlockModel {
  final int id;
  final String? name;
  final String? order;
  final String? color;

  BlockModel({required this.id, this.name, this.order, this.color});

  factory BlockModel.fromJson(Map<String, dynamic>? block) {
    if (block != null) {
      return BlockModel(
          id: block['id'],
          name: block['name'],
          order: block['order'],
          color: block['cor']);
    } else {
      return BlockModel(id: -1);
    }
  }
}
