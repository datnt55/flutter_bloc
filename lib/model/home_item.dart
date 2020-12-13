class HomeItem {
  HomeItemType _type;
  Object _data;

  HomeItem(this._type, this._data);

  Object get data => _data;

  HomeItemType get type => _type;
}

enum HomeItemType {
  HeaderBanner,
  QuickAccess,
  Section,
  SectionTitle,
  Product,
  Loading,
  SectionGroupBuy,
  HeaderBannerShimmer
}