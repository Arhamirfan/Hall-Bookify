class slide {
  final String imageURL;
  final String title;
  final String description;

  slide({
    required this.imageURL,
    required this.title,
    required this.description,
  });
}

final sliderList = [
  slide(
      imageURL: 'assets/images/fyplogo.png',
      title: "Make Weddings Easy",
      description:
          "The purpose of developing this application is to provide an easy and efficient way to get access to any event or meeting booking knowing every single information and reviews about the facility they want to book. It will reduce efforts and issues regarding booking. It will help a lot during event seasons as it will be helpful for new customers as well"),
  slide(
      imageURL: 'assets/images/bestchoice.png',
      title: "Choose The Best",
      description:
          "Hall Bookify is to provide easiness and relief to its customers and for this purpose it aims to provide facilities for better knowledge and experience about the service that customer needs to avail. Facilitating the customers to ensure their full relief and happiness is our motive."),
  slide(
      imageURL: 'assets/images/time.png',
      title: "Easy To Use",
      description:
          "The interface of Hall Bookify application will be easy to learn and provides detail description about the usability of the application. New users would be addressed using the previous customer reviews about a certain facility It will help him to know about the reputation of facility he wants to book. Application will have good aesthetics in sense of HCI (human computer interaction)")
];
