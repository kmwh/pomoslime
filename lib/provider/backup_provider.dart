import 'package:flutter/material.dart';
import 'package:pomoslime/model/calender_data_model.dart';
import 'package:pomoslime/model/user_data_model.dart';
import 'package:pomoslime/provider/sign_in_provider.dart';
import 'package:pomoslime/utils/encryption_helper.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:provider/provider.dart';

class BackupProvider with ChangeNotifier {
  final UserDataModel _userData;
  final CalenderDataModel _calenderData;
  bool _isLoading = false;

  BackupProvider(this._userData, this._calenderData);

  bool get isLoading => _isLoading;

  Future<void> backupData(BuildContext context) async {
    try {
      drive.DriveApi? api = context.read<SignInProvider>().driveApi;
      // 데이터를 암호화하여 저장
      if (api != null) {
        // 로딩 화면 띄우기
        setIsLoading(true);

        final encryptionHelper = EncryptionHelper(
            encrypt.Key.fromUtf8('32charactertoken32charactertoken'));

        final encryptedUserData =
            encryptionHelper.encryptData(jsonEncode(_userData.toMap()));
        final encryptedCalendarData =
            encryptionHelper.encryptData(jsonEncode(_calenderData.toMap()));

        var fileContent =
            utf8.encode('$encryptedUserData\n$encryptedCalendarData');
        var media = drive.Media(Stream.value(fileContent), fileContent.length);

        var driveFile = drive.File();
        driveFile.name = "pomoslime_backup_0";
        driveFile.parents = ['appDataFolder'];

        await api.files.create(driveFile, uploadMedia: media);

        // 로딩화면 제거
        setIsLoading(false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> restoreData(BuildContext context) async {
    try {
      drive.DriveApi? api = context.read<SignInProvider>().driveApi;
      if (api != null) {
        // 로딩 화면 띄우기
        setIsLoading(true);

        var fileList = await api.files.list(
          q: "name='pomoslime_backup_0' and 'appDataFolder' in parents",
          spaces: 'appDataFolder',
        );
        String? fileId;
        if (fileList.files != null && fileList.files!.isNotEmpty) {
          fileId = fileList.files!.first.id;
        }
        if (fileId != null) {
          var response = await api.files
              .get(fileId, downloadOptions: drive.DownloadOptions.fullMedia);

          if (response is drive.Media) {
            List<int> fileBytes = [];

            // Media의 stream을 읽어서 List<int>로 변환
            await response.stream.listen((data) {
              fileBytes.addAll(data);
            }).asFuture(); // 스트림 종료까지 기다림

            String fileContent = utf8.decode(fileBytes);

            var splitData = fileContent.split('\n');
            final encryptionHelper = EncryptionHelper(
                encrypt.Key.fromUtf8('32charactertoken32charactertoken'));

            String decryptedUserData =
                encryptionHelper.decryptData(splitData[0]);
            String decryptedCalendarData =
                encryptionHelper.decryptData(splitData[1]);

            var userDataMap = jsonDecode(decryptedUserData);
            var calendarDataMap = jsonDecode(decryptedCalendarData);

            _userData.updateFromMap(userDataMap);
            _calenderData.updateFromMap(calendarDataMap);
          }
        } else {
          debugPrint("Cannot finds file to restore.");
        }
      } else {
        debugPrint("You have to sign in google account.");
      }

      // 로딩화면 제거
      setIsLoading(false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
