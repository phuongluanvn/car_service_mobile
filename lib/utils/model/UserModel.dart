class UserModel {
  String username;
  String role;
  String deviceToken;
  Profile profile;
  String jwt;

  UserModel(
      {this.username, this.role, this.deviceToken, this.profile, this.jwt});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    deviceToken = json['deviceToken'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['role'] = this.role;
    data['deviceToken'] = this.deviceToken;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    data['jwt'] = this.jwt;
    return data;
  }
}

class Profile {
  String fullname;
  String phoneNumber;
  String address;
  String email;
  int accumulatedPoint;

  Profile(
      {this.fullname,
      this.phoneNumber,
      this.address,
      this.email,
      this.accumulatedPoint});

  Profile.fromJson(Map<String, dynamic> json) {
    fullname = json['Fullname'];
    phoneNumber = json['PhoneNumber'];
    address = json['Address'];
    email = json['Email'];
    accumulatedPoint = json['AccumulatedPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fullname'] = this.fullname;
    data['PhoneNumber'] = this.phoneNumber;
    data['Address'] = this.address;
    data['Email'] = this.email;
    data['AccumulatedPoint'] = this.accumulatedPoint;
    return data;
  }
}
