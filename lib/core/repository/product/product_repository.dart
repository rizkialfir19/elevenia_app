part of 'base_product_repository.dart';

class ProductRepository extends BaseProductRepository {
  final BaseApiClient apiClient;
  final String baseUrl;

  ProductRepository({
    required this.apiClient,
    required this.baseUrl,
  });

  @override
  Future<ProductDetail> getProductDetail({required String productNo}) async {
    Xml2Json xml2json = Xml2Json();

    Response fetchData = await apiClient.get(
      baseUrl + Url.productDetailRepository + "/$productNo",
      headers: {
        "openapikey": EnvConfig.OPEN_API_KEY,
      },
    );

    xml2json.parse(fetchData.toString());
    dynamic convertedJsonData = xml2json.toParker();
    dynamic decodeJson = jsonDecode(convertedJsonData);

    ProductDetail _result = ProductDetail.fromJson(
      Map<String, dynamic>.from(
        decodeJson['Product'],
      ),
    );

    return _result;
  }

  @override
  Future<List<ProductList>> getProductList({required String page}) async {
    List<ProductList> _results = [];
    Xml2Json xml2json = Xml2Json();

    Response fetchData = await apiClient.get(
      baseUrl + Url.productListRepository + "?page=$page",
      headers: {
        "openapikey": EnvConfig.OPEN_API_KEY,
      },
    );

    xml2json.parse(fetchData.toString());
    dynamic convertedJsonData = xml2json.toParker();
    dynamic decodeJson = jsonDecode(convertedJsonData);

    if (decodeJson['Products']['product'] != null &&
        decodeJson['Products']['product'] != null) {
      List _rawData = decodeJson['Products']['product'];
      for (Map singleData in _rawData) {
        _results.add(
          ProductList.fromJson(
            Map<String, dynamic>.from(
              singleData,
            ),
          ),
        );
      }
    }

    return _results;
  }
}
