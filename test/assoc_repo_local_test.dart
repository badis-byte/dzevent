import 'package:dzevent/data/repo/association/assoc_repo_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dzevent/data/models/assoc_model.dart';

import 'mocks.mocks.dart';

void main() {
  late MockAssociationTable mockAssociationTable;
  late MockDBAuth mockDBAuth;
  late AssocRepoLocal repo;

  setUp(() {
    mockAssociationTable = MockAssociationTable();
    mockDBAuth = MockDBAuth();

    repo = AssocRepoLocal(
      associatoinTable: mockAssociationTable,
      authTable: mockDBAuth,
    );
  });

  group('getData', () {
    test('returns list of AssociationModel', () async {
      when(mockAssociationTable.getAllRecords()).thenAnswer(
        (_) async => [
          {'id': 1, 'email': 'test@mail.com'},
        ],
      );

      final result = await repo.getData();

      expect(result, isA<List<AssociationModel>>());
      expect(result.length, 1);
      verify(mockAssociationTable.getAllRecords()).called(1);
    });
  });

  group('insertData', () {
    test('returns true when insert succeeds', () async {
      final model = AssociationModel(id: 1, createdAt: DateTime.now(), name: "Test", email:"test@email", password: "1234Abc",bio: "biobiobio", profilePicture: "1234567890", isVerified: true);

      when(mockAssociationTable.insertRecord(any))
          .thenAnswer((_) async => true);

      final result = await repo.insertData(model);

      expect(result, true);
      verify(mockAssociationTable.insertRecord(any)).called(1);
    });
  });

  group('deleteAllData', () {
    test('returns true when delete succeeds', () async {
      when(mockAssociationTable.deleteRecords())
          .thenAnswer((_) async => true);

      final result = await repo.deleteAllData();

      expect(result, true);
      verify(mockAssociationTable.deleteRecords()).called(1);
    });
  });

  group('login', () {
    test('returns AssociationModel when credentials are valid', () async {
      final association = AssociationModel(id: 1, createdAt: DateTime.now(), name: "Test", email:"test@email", password: "1234Abc",bio: "biobiobio", profilePicture: "1234567890", isVerified: true);

      when(mockDBAuth.getAssociationByCredentials(
        'test@mail.com',
        '1234',
      )).thenAnswer((_) async => association);

      final result = await repo.login('test@mail.com', '1234');

      expect(result, association);
      verify(mockDBAuth.getAssociationByCredentials(
        'test@mail.com',
        '1234',
      )).called(1);
    });
  });

  group('verifyAssociation', () {
    test('returns true when verification succeeds', () async {
      when(mockAssociationTable.verifyAssociation(1))
          .thenAnswer((_) async => true);

      final result = await repo.verifyAssociation(1);

      expect(result, true);
      verify(mockAssociationTable.verifyAssociation(1)).called(1);
    });
  });

  group('deleteAssociation', () {
    test('returns true when delete succeeds', () async {
      when(mockAssociationTable.deleteAssociation(1))
          .thenAnswer((_) async => true);

      final result = await repo.deleteAssociation(1);

      expect(result, true);
      verify(mockAssociationTable.deleteAssociation(1)).called(1);
    });
  });
}
