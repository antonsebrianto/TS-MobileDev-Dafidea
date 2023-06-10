class UserModel {
  String? email;
  String? password;
  int? id;
  String? name;
  String? gender;
  String? status;

  UserModel(
      {this.email,
      this.password,
      this.id,
      this.name,
      this.gender,
      this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['status'] = this.status;
    return data;
  }
}
