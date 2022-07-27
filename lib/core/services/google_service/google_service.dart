
import 'package:staarm_mobile/core/models/prediction.dart';

abstract class GoogleService {

  Future<List<AddressPrediction>> getSearchPredictions(String placeName);

}
