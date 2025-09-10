import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/model/request/customer_login_post_req.dart';
import 'package:flutter_application_1/model/response/customer_login_post_response.dart';
import 'package:flutter_application_1/pages/register.dart';
import 'package:flutter_application_1/pages/showtrip.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  String url = '';
  int number = 0;
  var phoneCtl = TextEditingController();
  var passwordCtl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Login page'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network(
              //   'https://hocco.co/wp-content/uploads/2023/09/Meme-01.jpeg.webp',
              // ),
              Image.asset('assets/images/22.jpg'),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "หมายเลขโทรศัพท์",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: phoneCtl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 20),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "รหัสผ่าน",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: passwordCtl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 20),
                        ),
                      ),
                      obscureText: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: register,
                          child: const Text(
                            'ลงทะเบียนเว้ย',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        FilledButton(
                          onPressed: login,
                          child: const Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void login() {
    // log(phoneCtl.text);
    // log(passwordCtl.text);
    // if (phoneCtl.text == '12345' && passwordCtl.text == '1234') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => ShowTripPage()),
    //   );
    // } else {
    //   setState(() {
    //     text = 'หมายเลขโทรศัพท์หรือรหัสผ่านผิด';
    //   });
    // }

    // http.get(Uri.parse('http://10.34.10.63:3000/customers')).then((value) {
    //   log(value.body);
    // });
    // CustomerLoginPostRequest customerLoginPostRequest =
    //     CustomerLoginPostRequest(phone: '0817399999', password: '1111');
    CustomerLoginPostRequest req = CustomerLoginPostRequest(
      phone: phoneCtl.text,
      password: passwordCtl.text,
    );
    var data = {"phone": "0817399999", "password": "1111"};
    http
        .post(
          Uri.parse("$url/customers/login"),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: customerLoginPostRequestToJson(req),
        )
        .then((value) {
          CustomerLoginPostResponse customerLoginPostResponse =
              customerLoginPostResponseFromJson(value.body);
          log(customerLoginPostResponse.customer.fullname);
          log(customerLoginPostResponse.customer.email);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShowTripPage(cid: customerLoginPostResponse.customer.idx),
            ),
          );
        })
        .catchError((error) {
          log('Error $error');
        });
  }
}
