import 'dart:io';


void main(List<String> arguments) {
  print('Welcome to GD Modusssssl Dart!');
  print('=========================');
  print('----------Login----------');
  stdout.write('Username: ');
  String? username = stdin.readLineSync();
  stdout.write('Password: ');
  String? password = stdin.readLineSync();
  stdout.write('NPM: ');
  String? npm = stdin.readLineSync();
  stdout.write('Kelas: ');
  String? kelas = stdin.readLineSync();

  LoginController loginController = LoginController();
  loginController.login(username: username?? '', password: password ?? '', npm: npm?? '', kelas: kelas?? '');
}

class LoginController{
  final LoginRepository loginRepository = LoginRepository();
  User userLogined = User();

  Future<void> login(
      {required String username, required String password, required String npm, required String kelas}) async{
    try{
      userLogined = await loginRepository.login(username, password, npm, kelas);
      print("Login Success... Here your User data ${userLogined.toString()}");
    } on FailedLogin catch (e){
      print(e.errorMessage());
    } on String catch(e){
      print(e);
    }finally{
      print("Login process has been completed");
    }
  }
}

class User{
  final String? name;
  final String? password;
  final String? token;
  final String? npm;
  final String? kelas;

  User({this.name, this.password, this.token, this.npm, this.kelas});

  @override
  String toString(){
    return 'User{name: $name, password: $password, token: $token, npm: $npm, kelas: $kelas}';
  }
}

class FailedLogin implements Exception{
  String errorMessage(){
    return "Login Failed";
  }
}

class LoginRepository{
  String username = "User";
  String password = "123";
  String npm = "220711666";
  String kelas = "D";

  Future<User> login(String username, String password, String npm, String kelas) async{
    print("Logining...");
    User userData = User();
    await Future.delayed(Duration(seconds: 3), (){
      if(this.username == username && this.password == password && this.npm == npm && this.kelas == kelas){
        userData = User(
          name: username,
          password: password,
          npm : npm,
          token: "12345",
          kelas : kelas);
      }else if(username == '' || password == '' || npm == '' || kelas == ''){
        throw 'Username or password or NPM or kelas cannot be empty';
      } else{
        throw FailedLogin();
      }
    });
    return userData;
  }
}
