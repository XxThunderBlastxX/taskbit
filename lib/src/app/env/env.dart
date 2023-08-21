import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'APPWRITE_PROJECT_ID')
  static String appwriteProjectID = _Env.appwriteProjectID;

  @EnviedField(varName: 'APPWRITE_ENDPOINT')
  static String appwriteEndpoint = _Env.appwriteEndpoint;

  @EnviedField(varName: 'DATABASE_ID')
  static String databaseID = _Env.databaseID;

  @EnviedField(varName: 'COLLECTION_ID')
  static String collectionID = _Env.collectionID;
}
