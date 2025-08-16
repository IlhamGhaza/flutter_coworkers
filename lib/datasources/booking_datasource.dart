import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_coworkers/config/app_log.dart';
import 'package:flutter_coworkers/config/appwrite.dart';
import 'package:flutter_coworkers/models/worker_model.dart';
import 'package:dartz/dartz.dart';

import '../models/booking_model.dart';

class BookingDatasource {
  static Future<Either<String, BookingModel>> checkHireBy(
    String workerId,
  ) async {
    try {
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionBooking,
        queries: [
          Query.equal('worker_id', workerId),
          Query.equal('status', 'In Progress'),
          Query.orderDesc('\$updatedAt'),
        ],
      );

      if (response.total < 1) {
        // available
        AppLog.error(body: 'Not Found', title: 'Booking - checkHireBy');
        return const Left('Tidak ditemukan');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Booking - checkHireBy',
      );

      BookingModel booking = BookingModel.fromJson(
        response.documents.first.data,
      );
      return Right(booking);
    } catch (e) {
      AppLog.error(body: e.toString(), title: 'Booking - checkHireBy');

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }

  static Future<Either<String, BookingModel>> checkout(
    BookingModel bookingDetail,
  ) async {
    try {
      final response = await Appwrite.databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionBooking,
        documentId: ID.unique(),
        data: bookingDetail.toJsonRequest(),
      );

      await Appwrite.databases.updateDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        documentId: bookingDetail.workerId,
        data: {'status': 'Booked'},
      );

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Booking - checkout',
      );

      return Right(BookingModel.fromJson(response.data));
    } catch (e) {
      AppLog.error(body: e.toString(), title: 'Booking - checkout');

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }

  static Future<Either<String, List<BookingModel>>> fetchOrder(
    String userId,
    String status,
  ) async {
    try {
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionBooking,
        queries: [
          Query.equal('user_id', userId),
          Query.equal('status', status),
          Query.orderDesc('\$updatedAt'),
        ],
      );

      if (response.total < 1) {
        // available
        AppLog.error(
          body: 'Not Found',
          title: 'Booking - fetchOrder - $status',
        );
        return const Left('Tidak ditemukan');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Booking - fetchOrder - $status',
      );

      List<BookingModel> orders = [];
      for (Document doc in response.documents) {
        final responseWorker = await Appwrite.databases.getDocument(
          databaseId: Appwrite.databaseId,
          collectionId: Appwrite.collectionWorkers,
          documentId: doc.data['worker_id'],
        );
        WorkerModel worker = WorkerModel.fromJson(responseWorker.data);
        BookingModel booking = BookingModel.fromJson(doc.data, worker: worker);
        orders.add(booking);
      }

      return Right(orders);
    } catch (e) {
      AppLog.error(body: e.toString(), title: 'Booking - fetchOrder - $status');

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }

  static Future<Either<String, BookingModel>> setCompleted(
    String bookingId,
    String workerId,
  ) async {
    try {
      final response = await Appwrite.databases.updateDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionBooking,
        documentId: bookingId,
        data: {'status': 'Completed'},
      );

      await Appwrite.databases.updateDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        documentId: workerId,
        data: {'status': 'Available'},
      );

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Booking - setCompleted',
      );

      return Right(BookingModel.fromJson(response.data));
    } catch (e) {
      AppLog.error(body: e.toString(), title: 'Booking - setCompleted');

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }
}
