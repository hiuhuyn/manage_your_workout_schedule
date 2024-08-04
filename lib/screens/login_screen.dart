import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_your_workout_schedule/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passworkController = TextEditingController();

  String? errorPasswork;
  String? errorUsername;
  @override
  void initState() {
    super.initState();
    errorUsername = "Tên đăng nhập phải là email";
    errorPasswork = "Mật khẩu phải có ít nhất 6 ký tự";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Text(
              "Quản lý chế độ luyện tập",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(
              flex: 1,
            ),
            TextFormField(
              controller: usernameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Nhập tên tài khoản...",
                labelText: "Tài khoản",
                errorText: errorUsername,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.endsWith("@gmail.com")) {
                    errorUsername = null;
                  } else {
                    errorUsername = "Tên đăng nhập phải là email";
                  }
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passworkController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Nhập mật khẩu",
                labelText: "Mật khẩu",
                errorText: errorPasswork,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.length < 6) {
                    errorPasswork = "Mật khẩu phải có ít nhất 6 ký tự";
                  } else {
                    errorPasswork = null;
                  }
                });
              },
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    if (errorPasswork != null || errorUsername != null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text("Thông báo"),
                          content: const Text(
                            "Vui lòng điền đầy đủ thông tin và mật khẩu hợp lệ",
                            style: TextStyle(color: Colors.red),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text("Thông báo"),
                          content: const Text(
                            "Đăng nhập thành công",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const HomeScreen();
                                  },
                                ));
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            const Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
