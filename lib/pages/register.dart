import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ลงทะเบียนสมาชิกใหม่')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ชื่อ-นามสกุล", style: TextStyle(fontSize: 18)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 20),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Text("หมายเลขโทรศัพท์", style: TextStyle(fontSize: 18)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 20)),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Text("อีเมล", style: TextStyle(fontSize: 18)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 20),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Text("รหัสผ่าน", style: TextStyle(fontSize: 18)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 20)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Text("ยืนยันรหัสผ่าน", style: TextStyle(fontSize: 18)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 20)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(onPressed: () {}, child: Text('สมัครสมาชิก')),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('หากมีบัญชีอยู่แล้ว', style: TextStyle(fontSize: 18)),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
