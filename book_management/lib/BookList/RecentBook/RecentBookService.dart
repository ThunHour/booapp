import 'package:book_management/Model/BookModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentBookService {

  removeDuplicate(List<BookModel> books){
    return books.toSet().toList();
  }

  addRecent(BookModel book, List<BookModel> books){
    int flag = 0;
    if (books.length >= 20) {
      books.removeLast();
    }
    books.forEach((element) {
      if (element.id == book.id) {
        flag = element.id;
      }
    });
    books.removeWhere((item) => item.id == flag);
    books.insert(0, book);
  }

  Stream<List<BookModel>> loadRecentStream() async* {
    final books = await loadRecent();
    yield books;
  }

  Future<List<BookModel>> loadRecent() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final res = prefs.getString("recent");
      final books = BookModel.decode(res!);
      return books;
    } catch (e) {
      return bookData;
    }
  }

  saveRecent(List<BookModel> books) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("recent", BookModel.encode(books));
  }

  void removeRecent() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("recent");
  }

  List<BookModel> bookData = [
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
        id: 21,
        title: "Think and Grow Rich",
        description: "This book contains money-making secrets that can change your life. Think and Grow Rich, based on the author's famed Law of Success, represents the distilled wisdom of distinguished men of great wealth and achievement. ",
        genre: "Non-fiction",
        author: "Napoleon Hill ",
        imgUrl: "https://cdn.asaha.com/assets/thumbs/945/945bf6f19ca0bdf75608e630ca081c56.jpg",
        downloadUrl: "https://www.pdfdrive.com/download.pdf?id=19596336&h=3dc4c18ceb2d2fa55a8cd603592d47fe&u=cache&ext=pdf"
    ),
    new BookModel(
        id: 16,
        title: "Rich Dad Poor Dad",
        description: "It advocates the importance of financial literacy, financial independence and building wealth through investing in assets, real estate investing, starting and owning businesses, as well as increasing one's financial intelligence.",
        genre: "Personal Finance",
        author: " Robert Kiyosaki, Sharon Lechter",
        imgUrl: "https://cdn.asaha.com/assets/thumbs/29c/29c31e04c5e8eb202e16918b95c55351.jpg",
        downloadUrl: "https://www.pdfdrive.com/download.pdf?id=136494023&h=1aa480a89378f61c111d68cdd8632b97&u=cache&ext=pdf"
    ),
  ];
}