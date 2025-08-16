import 'package:appwrite/appwrite.dart';
import 'package:flutter_coworkers/config/app_log.dart';
import 'package:flutter_coworkers/config/appwrite.dart';
import 'package:flutter_coworkers/models/worker_model.dart';
import 'package:dartz/dartz.dart';

class WorkerDatasource {
  static Future<Either<String, List<WorkerModel>>> fetchAvailable(
    String category,
  ) async {
    try {
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        queries: [
          Query.equal('category', category),
          Query.equal('status', 'Available'),
        ],
      );

      if (response.total < 1) {
        AppLog.error(body: 'Not Found', title: 'Worker - fetchAvailable');

        return const Left('Tidak ditemukan');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Worker - fetchAvailable',
      );

      List<WorkerModel> workers = response.documents.map((e) {
        return WorkerModel.fromJson(e.data);
      }).toList();

      return Right(workers);
    } catch (e) {
      AppLog.error(body: e.toString(), title: 'Worker - fetchAvailable');

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }
}
