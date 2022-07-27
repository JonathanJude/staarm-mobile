class Config {
  static bool isProd;
  String baseURL;

  Config() {
    // if (env['DEBUG'] != 'true') {
    //   isProd = true;
    // } else {
    //   isProd = false;
    // }

    print('is env is $isProd');
    // if (isProd) {
    //   baseURL = ConfigReader.getProdUrl();
    // } else {
    //   baseURL = ConfigReader.getDevUrl();
    // }

    // baseURL = 'http://test.api.staarm.com/api/v1/';
    baseURL = 'http://api.staarm.com/api/v1/';
  }
}
