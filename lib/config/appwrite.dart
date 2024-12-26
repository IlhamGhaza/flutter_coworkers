import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const projectId = '676d1877003db151bea8'; //your project id
  static const endpoint = 'https://cloud.appwrite.io/v1';

  static const databaseId = '676d378a00035b1b307f'; //your database id
  static const collectionUser = '676d3a12003bedbfbdc2'; //your collection id
  static const collectionWorkers = '676d3a3a000937dc9587'; //your collection id
  static const collectionBooking = '676d3a49002a7ad0f44d'; //your collection id

  static const bucketWorker = '676d47db001f596a6ac8'; //your bucket id

  static Client client = Client();
  static late Account? account;
  static late Databases? database;

  static init() {
    client.setProject(projectId).setEndpoint(endpoint);
    account = Account(client);
    database = Databases(client);
  }

  String imageUrl(String fileID){
    return '$endpoint/storage/buckets/$bucketWorker/files/$fileID/view?project=$projectId';
  }
}
