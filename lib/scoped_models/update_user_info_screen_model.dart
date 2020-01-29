import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/services/authentication.dart';

class UpdateUserInfoScreenModel extends Model {
  String profilePicture;
  File image;
  String fileName;
  String uploadedFileURL;
  AuthenticationService auth = AuthenticationService();
  FirebaseUser user;

  Future updateProfilePicture() async {
    await ImagePicker.pickImage(source: ImageSource.gallery)
        .then((pickedImage) async {
      image = pickedImage;
      fileName = basename(image.path);
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      await storageReference.getDownloadURL().then((fileURL) {
        uploadedFileURL = fileURL;
      });
      user = await auth.getCurrentUser();
      final CollectionReference usersCollection =
          Firestore.instance.collection('Users');
      await usersCollection
          .document(user.uid)
          .updateData({'profile_picture': uploadedFileURL});
      notifyListeners();
    });
  }

  notifyListeners();
}

UpdateUserInfoScreenModel updateUserInfoScreenModel =
    UpdateUserInfoScreenModel();
