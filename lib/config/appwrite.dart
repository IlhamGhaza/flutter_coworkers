import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const projectId = '676d1877003db151bea8';
  static const endpoint = 'https://cloud.appwrite.io/v1';

  static const databaseId = '64c60901c882c2ab5e0d';
  static const collectionUsers = '64c60935548fe5530d13';
  static const collectionWorkers = '64c60950b7b8ad8aada2';
  static const collectionBooking = '64c6095ea299a9013301';
  static const bucketWorker = '64c6107e6b2f8de9174a';

  static Client client = Client();
  static late Account account;
  static late Databases databases;

  static init() {
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
