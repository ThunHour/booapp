import 'dart:convert';

class BookModel {
  final int id;
  final String title, description, genre, author, imgUrl, downloadUrl;

  BookModel({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.author,
    required this.imgUrl,
    required this.downloadUrl,
  });

  static Map<String, dynamic> toJson(BookModel book) => {
    'id': book.id,
    'title': book.title,
    'description': book.description,
    'genre': book.genre,
    'author': book.author,
    'imgUrl': book.imgUrl,
    'downloadUrl': book.downloadUrl,
  };

  BookModel.fromJson(Map<String, dynamic> json):
        id = json['id'],
        title = json['title'],
        description = json['description'],
        genre = json['genre'],
        author = json['author'],
        imgUrl = json['imgUrl'],
        downloadUrl = json['downloadUrl'];

  static encode(List<BookModel> books) => json.encode(
      books.map<Map<String, dynamic>>((book) => BookModel.toJson(book)).toList(),
  );

  static List<BookModel> decode(String books) =>
      (json.decode(books) as List<dynamic>).map<BookModel>((item) => BookModel.fromJson(item)).toList();
}

List<BookModel> allBookData = [
  new BookModel(
      id: 8,
      title: "The 6 Most Important Decisions You’ll Ever Make",
      description: "In this newly revised edition, Sean Covey helps teens figure out how to approach the six major challenges they face: gaining self-esteem, dealing with their parents, making friends, being wise about sex, coping with substances, and succeeding at school and planning a career.",
      genre: "Personal Growth",
      author: "Sean Covey",
      imgUrl: "https://images-na.ssl-images-amazon.com/images/I/71xgNZAmYOL.jpg",
      downloadUrl: "https://www.pdfdrive.com/download.pdf?id=195063037&h=d70b6552ded769c73db4af77f3a2d49a&u=cache&ext=pdf"
  ),
  new BookModel(
      id: 12,
      title: "Web Design with HTML and CSS",
      description: "An invaluable full-color training package for Web design Web design consists of using multiple software tools and codes-such as Dreamweaver, Flash, Silverlight, Illustrator, Photoshop, HTML, and CSS, among others-to craft a unique, robust, and interactive websites.",
      genre: "Technology",
      author: "Jennifer Smith",
      imgUrl: "https://cdn.asaha.com/assets/thumbs/3e0/3e0e35e2305c83820e7f7375aaabe6e0.jpg",
      downloadUrl: "https://stevebraysduis.files.wordpress.com/2014/02/web-design-with-html-and-css-digital-classroom.pdf"
  ),
  new BookModel(
      id: 8,
      title: "The 6 Most Important Decisions You’ll Ever Make",
      description: "In this newly revised edition, Sean Covey helps teens figure out how to approach the six major challenges they face: gaining self-esteem, dealing with their parents, making friends, being wise about sex, coping with substances, and succeeding at school and planning a career.",
      genre: "Personal Growth",
      author: "Sean Covey",
      imgUrl: "https://images-na.ssl-images-amazon.com/images/I/71xgNZAmYOL.jpg",
      downloadUrl: "https://www.pdfdrive.com/download.pdf?id=195063037&h=d70b6552ded769c73db4af77f3a2d49a&u=cache&ext=pdf"
  ),
  new BookModel(
      id: 12,
      title: "Web Design with HTML and CSS",
      description: "An invaluable full-color training package for Web design Web design consists of using multiple software tools and codes-such as Dreamweaver, Flash, Silverlight, Illustrator, Photoshop, HTML, and CSS, among others-to craft a unique, robust, and interactive websites.",
      genre: "Technology",
      author: "Jennifer Smith",
      imgUrl: "https://cdn.asaha.com/assets/thumbs/3e0/3e0e35e2305c83820e7f7375aaabe6e0.jpg",
      downloadUrl: "https://stevebraysduis.files.wordpress.com/2014/02/web-design-with-html-and-css-digital-classroom.pdf"
  ),
];