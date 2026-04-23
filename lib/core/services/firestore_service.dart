import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app_assessment/core/errors/app_exception.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> collection(String path) {
    return _firestore.collection(path);
  }

  Future<T> _handleFirestoreCall<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on FirebaseException catch (e) {
      throw DatabaseException(
        message: e.message ?? 'A database error occurred.',
        code: e.code,
      );
    } catch (e) {
      throw DatabaseException(message: 'An unexpected database error occurred.');
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> addDocument<T>({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    return _handleFirestoreCall(
          () => _firestore.collection(collectionPath).add(data),
    );
  }

  Future<void> setDocument<T>({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    return _handleFirestoreCall(
          () => _firestore
          .collection(collectionPath)
          .doc(documentId)
          .set(data),
    );
  }

  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    return _handleFirestoreCall(
          () => _firestore
          .collection(collectionPath)
          .doc(documentId)
          .update(data),
    );
  }

  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    return _handleFirestoreCall(
          () => _firestore
          .collection(collectionPath)
          .doc(documentId)
          .delete(),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDocuments({
    required String collectionPath,
    List<QueryFilter>? filters,
    QueryOrder? orderBy,
    int? limit,
  }) async {
    return _handleFirestoreCall(() {
      Query<Map<String, dynamic>> query =
      _firestore.collection(collectionPath);

      if (filters != null) {
        for (final filter in filters) {
          query = query.where(
            filter.field,
            isEqualTo: filter.isEqualTo,
            isGreaterThan: filter.isGreaterThan,
            isLessThan: filter.isLessThan,
          );
        }
      }

      if (orderBy != null) {
        query = query.orderBy(
          orderBy.field,
          descending: orderBy.descending,
        );
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      return query.get();
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDocuments({
    required String collectionPath,
    List<QueryFilter>? filters,
    QueryOrder? orderBy,
  }) {
    Query<Map<String, dynamic>> query =
    _firestore.collection(collectionPath);

    if (filters != null) {
      for (final filter in filters) {
        query = query.where(
          filter.field,
          isEqualTo: filter.isEqualTo,
        );
      }
    }

    if (orderBy != null) {
      query = query.orderBy(
        orderBy.field,
        descending: orderBy.descending,
      );
    }

    return query.snapshots();
  }
}

class QueryFilter {
  final String field;
  final dynamic isEqualTo;
  final dynamic isGreaterThan;
  final dynamic isLessThan;

  const QueryFilter({
    required this.field,
    this.isEqualTo,
    this.isGreaterThan,
    this.isLessThan,
  });
}

class QueryOrder {
  final String field;
  final bool descending;

  const QueryOrder({
    required this.field,
    this.descending = false,
  });
}
