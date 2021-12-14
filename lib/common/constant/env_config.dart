class EnvConfig {
  static const BASE_PROD_URL = String.fromEnvironment(
    'http://api.elevenia.co.id/rest/prodservices/product/',
    defaultValue: 'http://api.elevenia.co.id/rest/prodservices/product/',
  );

  // Can add Staging or Dev URL here

  static const OPEN_API_KEY = String.fromEnvironment(
    '721407f393e84a28593374cc2b347a98',
    defaultValue: '721407f393e84a28593374cc2b347a98',
  );
}
