import 'dart:ffi';

class SignUpRequest {
  final String username;
  final String email;
  final String phone;
  final String lastname;
  final String firstname;
  final String gender;
  final String password;
  final int idRole;

  SignUpRequest(this.username, this.email, this.phone, this.password, this.lastname, this.firstname, this.gender, this.idRole);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username' : username.trim(),
      'email' : email.trim(),
      'password' : password.trim(),
      'phone' : phone.trim(),
      'firstname' : firstname.trim(),
      'lastname' : lastname.trim(),
      'sex' : gender.trim(),
      'idRole' : idRole
    };
    return map;
  }  
}