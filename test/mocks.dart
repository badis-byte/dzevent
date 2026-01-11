import 'package:dzevent/data/databases/db_association.dart';
import 'package:dzevent/data/databases/db_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AssociationTable, DBAuth])
class MockHttpClient extends Mock implements http.Client {}
void main() {}
