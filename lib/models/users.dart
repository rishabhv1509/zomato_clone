class Users {
  String firstName;
  String lastName;
  String profilePricture;
  String email;
  String password;
  String phoneNo;

  Users(this.firstName, this.lastName, this.profilePricture, this.email,
      this.password, this.phoneNo);

  Users.fromJson(Map<String, dynamic> json) {
    firstName = (json['first_name'] == null) ? 'John' : json['first_name'];
    lastName = (json['last_name'] == null) ? '' : json['last_name'];
    email = (json['email_id'] == null) ? 'test@test.com' : json['email_id'];
    password = (json['password'] == null) ? 'hello123' : json['password'];
    phoneNo =
        (json['phone_number'] == null) ? '99999999' : json['phone_number'];
    profilePricture = (json['profile_picture'] == null ||
            json['profile_picture'] == '')
        ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
        : json['profile_picture'];
  }
}
