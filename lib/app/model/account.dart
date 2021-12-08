


class Account {
  String? first_name;
  String? last_name;
  String? email;
  String? phone_number;
  String? contact;
  String? dob;
  String? password;

  Account(
      {
        this.first_name,
        this.last_name,
        this.email,
        this.phone_number,
        this.contact,
        this.dob,
         this.password});

  Account.fromJson(Map<String, String> json) {
    first_name = json['first_name'];
    last_name = json['last_name'];
    email = json['email'];
    phone_number = json['phone_number'];
    contact = json['contact'];
    dob = json['dob'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, String>();
    data['first_name'] = this.first_name ?? '';
    data['last_name'] = this.last_name ?? '';
    data['email'] = this.email ?? '';
    data['phone_number'] = this.phone_number ?? '';
    data['contact'] = this.contact ?? '';
    data['dob'] = this.dob ?? '';
    data['password'] = this.password ?? '';
    return data;
  }
}