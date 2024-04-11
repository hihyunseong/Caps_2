import 'package:flutter/material.dart';

class HomeSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈 설정'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text('언어 설정'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
    
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('알림 설정'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
             
            },
          ),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('다크 모드'),
            trailing: Switch(
              value: true, 
              onChanged: (value) {
               
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('위치 서비스 설정'),
            trailing: Switch(
              value: true, 
              onChanged: (value) {
              
              },
            ),
          ),
         
        ],
      ),
    );
  }
}
