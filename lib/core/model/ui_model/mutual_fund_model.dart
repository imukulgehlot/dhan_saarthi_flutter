class MutualFundModel {
  final String name;
  final String image;
  final bool isSaved;
  final String oneYearPercent;
  final String threeYearPercent;
  final String fiveYearPercent;
  final String nav;
  final String expRatio;

  MutualFundModel(
      {required this.name,
      required this.image,
      required this.isSaved,
      required this.oneYearPercent,
      required this.threeYearPercent,
      required this.fiveYearPercent,
      required this.nav,
      required this.expRatio});
}
