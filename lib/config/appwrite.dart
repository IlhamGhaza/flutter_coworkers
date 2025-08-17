import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const projectId = '676d1877003db151bea8';
  static const endpoint = 'https://cloud.appwrite.io/v1';

  static const databaseId = '676d378a00035b1b307f';
  static const collectionUsers = '676d3a12003bedbfbdc2';
  static const collectionWorkers = '676d3a3a000937dc9587';
  static const collectionBooking = '676d3a49002a7ad0f44d';
  static const bucketWorker = '676d47db001f596a6ac8';

  static Client client = Client();
  static late Account account;
  static late Databases databases;

  static void init() {
    client
        .setEndpoint(endpoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    account = Account(client);
    databases = Databases(client);
  }

  static String imageURL(String fileId) {
    return '$endpoint/storage/buckets/$bucketWorker/files/$fileId/view?project=$projectId';
  }
}
