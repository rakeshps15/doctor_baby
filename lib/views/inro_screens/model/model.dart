class Items {
  final String img;
  final String title;
  final String subTitle;

  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/intro_images/in1.jpg",
    title: "Learning Sign Language is\n an invaluable Skill",
    subTitle: "",
  ),
  Items(
    img: "assets/intro_images/in2.jpg",
    title: "It allows you to communicate with people who have difficulty communicating verbally",
    subTitle: "",
  ),
  Items(
    img: "assets/intro_images/in3.jpg",
    title:"It is the only mode of communication for such people to convey their messages",
    subTitle: "",
  ),
];
