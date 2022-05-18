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
              "Welcome Franchise owner",
          img: "assets/images/moneyvisionImage.png"),
      OnBoardModel(
        title: "Lorem ispum",
          message: "You can manage leads, check money vision services and can manage your own profile, with the help of this application",
          img: "assets/images/moneyvisionImage.png"),
      OnBoardModel(
          title: "Lorem ispum",
          message: "For more details please contact +91999999999",
          img: "assets/images/moneyvisionImage.png")
    ];
  }
}
