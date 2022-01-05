


class Account {
  String? first_name;
  String? last_name;
  String? email;
  String? phone_number;
  String? state_of_residence;
  String? lga_of_residence;
  String? address;
  String? dob;
  String? password;

  Account(
      {
        this.first_name,
        this.last_name,
        this.email,
        this.phone_number,
        this.state_of_residence,
        this.lga_of_residence,
        this.address,
        this.dob,
         this.password});

  Account.fromJson(Map<String, String> json) {
    first_name = json['first_name'];
    last_name = json['last_name'];
    email = json['email'];
    phone_number = json['phone_number'];
    address = json['address'];
    state_of_residence = json['state_of_residence'];
    lga_of_residence = json['lga_of_residence'];
    dob = json['dob'];
    password = json['password'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, String>();
    data['first_name'] = this.first_name ?? '';
    data['last_name'] = this.last_name ?? '';
    data['email'] = this.email ?? '';
    data['phone_number'] = this.phone_number ?? '';
    data['state_of_residence'] = this.state_of_residence ?? '';
    data['lga_of_residence'] = this.lga_of_residence ?? '';
    data['address'] = this.address ?? '';
    data['dob'] = this.dob ?? '';
    data['password'] = this.password ?? '';
    return data;
  }
}