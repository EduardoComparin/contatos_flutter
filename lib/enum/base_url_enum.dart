import 'package:flutter_dotenv/flutter_dotenv.dart';

enum BaseUrlEnum{
  
  BACK4APP;

  
getUrl() {
  return  dotenv.get(this.name);
}
getApiKey() {
  return  dotenv.get(this.name+'APIKEY');
}
getID() {
  return  dotenv.get(this.name+'ID');
}

}