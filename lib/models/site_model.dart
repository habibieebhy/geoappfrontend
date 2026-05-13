class SiteModel {
  final int? id;

  final String? ownerName;
  final String? dealerName;
  final String? currentBrandUsing;
  final String? siteImageUrl;

  SiteModel({
    this.id,
    this.ownerName,
    this.dealerName,
    this.currentBrandUsing,
    this.siteImageUrl,
  });

  factory SiteModel.fromJson(Map<String, dynamic> json) {
    return SiteModel(
      id: json['id'],
      ownerName: json['ownerName'],
      dealerName: json['dealerName'],
      currentBrandUsing: json['currentBrandUsing'],
      siteImageUrl: json['siteImageUrl'],
    );
  }
}