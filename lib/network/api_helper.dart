
class APIHelper {
  static const baseUrl = 'https://f99apim.azure-api.net/';

  static const security_code = 'b03c9f82fb0e4926904b5b36070bc39d';

  // List Service
  static const catalog_service = '${baseUrl}catalog/v2';

  static const seller_service = '${baseUrl}seller/v2';

  // List API
  static const url_banner = '$catalog_service/api/Home/Banners';

  static const url_quick_access = '$catalog_service/api/Home/QuickAccess';

  static const url_list_section = '$catalog_service/api/Home/HSections';

  static const url_list_product = '$catalog_service/api/CollectionProduct/';

  static const url_product_detail = '$catalog_service/api/Products/';

  static const url_seller_detail = '$seller_service/api/Sellers/';
}