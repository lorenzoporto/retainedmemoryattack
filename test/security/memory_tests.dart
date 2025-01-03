import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

import 'memory_protection.dart';

class SecureBook {
  final String _id;
  final String _title;
  String? _authorName;
  bool _isDeleted = false;

  String get id => _id;
  String get title => _title;

  SecureBook(this._id, this._title);

  void dispose() {
    _authorName = null;
    _isDeleted = true;
  }

  @override
  String toString() {
    return 'Book: ${_title.hashCode}';
  }
}

void main() {
  group('MemoryProtection Tests', () {
    test('DevTools connection detection', () {
      expect(MemoryProtection.checkDevToolsConnection(), isFalse);
      expect(MemoryProtection.checkMemoryExposure(), isFalse);
    });

    test('Secure disposal', () {
      final book = SecureBook('sensitive', 'data');
      MemoryProtection.secureDispose(book);
      expect(book._isDeleted, isTrue);
      expect(book._authorName, isNull);
    });

    test('Multiple secure disposals', () {
      final books = List.generate(10, (i) => SecureBook('id_$i', 'data_$i'));
      books.forEach(MemoryProtection.secureDispose);
      for (var book in books) {
        expect(book._isDeleted, isTrue);
        expect(book._authorName, isNull);
      }
    });

    test('Non-SecureBook objects disposal', () {
      final nonBook = Object();
      MemoryProtection.secureDispose(nonBook); // Should not throw
    });
  });
}