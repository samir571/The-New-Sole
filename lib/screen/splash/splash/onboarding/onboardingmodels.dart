class onboardingModel {
  final String? imagePath;
  final String? title;
  final String? desc;

  onboardingModel({
    this.imagePath,
    this.title,
    this.desc,
  });

  static List<onboardingModel> data = [
    onboardingModel(
        imagePath: 'assets/images/onboard1.png',
        title: 'Smart Shopping, Smart You!',
        desc: 'Always check products and seller\n rating before buying'),
    onboardingModel(
        imagePath: 'assets/images/onboard2.png',
        title: 'Secure Payment',
        desc:
            'Variety of payment options including\n cash on delivery and bank cards'),
    onboardingModel(
        imagePath: 'assets/images/onboard3.png',
        title: 'Fast Delivery',
        desc:
            'Discover the best producrs from GYPSY GEAR\n and fast deliver to your doorstep'),
  ];
}
