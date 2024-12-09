class Post {
  final int id;
  final String title;
  final String content;
  final String? image;

  Post({
    required this.id,
    required this.title,
    required this.content,
    this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      image: json['_embedded']?['wp:featuredmedia']?[0]?['source_url'],
    );
  }
}
