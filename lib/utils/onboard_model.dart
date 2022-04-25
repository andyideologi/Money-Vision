class OnBoardModel {
  String message;
  String img;
  String title;

  OnBoardModel({required this.message, required this.img,required this.title});
}

class Utils {
  static List<OnBoardModel> getOnBoard() {
    return [
      OnBoardModel(
        title: "Lorem Ispum",
          message:
              "Lorem ipsum dolor sit amet",
          img: "assets/images/lead.png"),
      OnBoardModel(
        title: "Lorem ispum",
          message: "Lorem ipsum dolor sit amet", 
          img: "assets/images/lead.png"),
      OnBoardModel(
          title: "Lorem ispum",
          message: "Lorem ipsum dolor sit amet", 
          img: "assets/images/lead.png")
    ];
  }
}
