import 'dart:convert';

import 'package:http/http.dart';
import 'package:qr_smartstorage/resources/storage_root.dart';
import 'package:qr_smartstorage/storage/repository.dart';

class GoogleRepository extends Repository {
  final String _accessToken;
  final String filename = "storage.json";

  GoogleRepository(this._accessToken);

  Future<String?> _getDBFileIdFromDrive() async {
    final Map<String, String> queryParameters = {
      'spaces': 'appDataFolder',
      'q': 'name = "$filename"',
    };
    final headers = {'Authorization': 'Bearer $_accessToken'};
    final uri =
        Uri.https('www.googleapis.com', '/drive/v3/files', queryParameters);
    final response = await get(uri, headers: headers);
    Map<String, dynamic> parsed = jsonDecode(response.body);
    try {
      String id = parsed["files"][0]["id"];
      return id;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<StorageRoot> getRoot() async {
    final fileId = await _getDBFileIdFromDrive();
    if (fileId == null) {
      return StorageRoot();
    } else {
      final headers = {'Authorization': 'Bearer $_accessToken'};
      final url = Uri.parse(
          'https://www.googleapis.com/drive/v3/files/$fileId?alt=media');
      final response = await get(url, headers: headers);
      return this.parseRoot(utf8.decode(response.bodyBytes));
    }
  }

  @override
  Future<void> saveRoot(StorageRoot root) async {
    final fileId = await _getDBFileIdFromDrive();
    if (fileId == null) {
      final headers = {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json; charset=UTF-8'
      };
      final initialQueryParameters = {'uploadType': 'resumable'};
      final Map<String, dynamic> metaData = {
        'name': filename,
        'parents': ['appDataFolder']
      };
      final initiateUri = Uri.https('www.googleapis.com',
          '/upload/drive/v3/files', initialQueryParameters);
      final initiateResponse = await post(initiateUri,
          headers: headers, body: json.encode(metaData));
      final location = initiateResponse.headers['location'];

      final headers2 = {'Authorization': 'Bearer $_accessToken'};
      final uploadUri = Uri.parse(location!);
      final uploadResponse =
          await put(uploadUri, headers: headers2, body: json.encode(root));
      print("Upload result: $uploadResponse");
      print(uploadResponse.body);
    } else {
      final headers = {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json; charset=UTF-8'
      };
      final initiateUri =
          Uri.https('www.googleapis.com', '/upload/drive/v3/files/$fileId');
      await patch(initiateUri, headers: headers, body: json.encode(root));
    }
  }
}
