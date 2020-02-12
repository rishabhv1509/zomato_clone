import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/scoped_models/update_user_info_screen_model.dart';
import 'package:zomato_clone/utils/constants/strings.dart';

class UpdateUserInfoScrceen extends StatelessWidget {
  final Users user;

  const UpdateUserInfoScrceen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UpdateUserInfoScreenModel>(
      model: updateUserInfoScreenModel,
      child: ScopedModelDescendant<UpdateUserInfoScreenModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppStrings.UPDATE_USER_INFO),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            border: Border.all(color: Colors.transparent),
                            image: DecorationImage(
                                image: NetworkImage(user.profilePricture)),
                            color: Colors.transparent),
                        child: Container(
                          child: FloatingActionButton(
                            onPressed: () {
                              model.updateProfilePicture();
                            },
                            child: Icon(Icons.add),
                          ),
                          height: 40,
                          width: 40,
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(user.firstName),
                      SizedBox(
                        height: 30,
                      ),
                      Text(user.email)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
