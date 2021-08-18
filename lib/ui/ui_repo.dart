import 'package:p16task/constants/api_endpoint.dart';
import 'package:p16task/ui/provider.dart';

class AppRepo {
  MasterProvider masterProvider = MasterProvider();

  Future countriesData() async {
    return masterProvider.get(API_ENDPOINT.resAllCountries);
  }

  Future regionWiseCountries(String region) async {
    return masterProvider.get(API_ENDPOINT.regionWiseCountry+region);
  }
}
