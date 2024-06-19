import 'dart:convert';
import 'dart:io';

import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:caps_2/vo/UrlUtil.dart';
import 'package:caps_2/widgets/sub_title_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';
import 'package:image/image.dart' as img;

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _nickNameController = TextEditingController();

  File? _image;

  String? idx;
  String? email;
  String? name;
  String? profile;
  String? accToken;
  String? refToken;

  final storage = const FlutterSecureStorage();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final loadIdx = await storage.read(key: 'idx');
    final loadEmail = await storage.read(key: 'email');
    final loadName = await storage.read(key: 'name');
    final loadProfile = await storage.read(key: 'profile');
    final loadAccToken = await storage.read(key: 'accToken');
    final loadRefToken = await storage.read(key: 'refToken');

    setState(() {
      idx = loadIdx;
      email = loadEmail;
      name = loadName;
      profile = loadProfile;
      accToken = loadAccToken;
      refToken = loadRefToken;
      if (name != null) {
        _nickNameController.text = name!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '프로필 수정',
          style: TextStyle(
            fontSize: 20,
            fontFamily: "NanumSquareNeo-Bold",
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                _profileImageStack(),
                const SizedBox(height: 10),
                _profileName(),
                const SizedBox(height: 20),
                const SubTitleWidget(subTitle: '닉네임', fontSize: 16),
                const SizedBox(height: 10),
                _nickNameTextField(),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: '완료',
                height: 70,
                color: Colors.red[300]!,
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  _updateProfile();
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileImageStack() {
    Widget profileWidget;
    if (profile == null) {
      profileWidget = Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: 35.0,
          color: Colors.grey[600],
        ),
      );
    } else {
      if (_image == null) {
        profileWidget = ClipOval(
          child: Image.network(
            profile!,
            width: 90,
            height: 90,
          ),
        );
      } else {
        profileWidget = ClipOval(
          child: Image.memory(
            _image!.readAsBytesSync(),
            width: 90,
            height: 90,
          ),
        );
      }
    }
    return Column(
      children: [
        Stack(
          children: [
            profileWidget,
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  _showImagePickerDialog(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.red[300]!,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _profileName() {
    return Center(
      child: Text(
        name ?? '',
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'NanumSquareNeo-Bold',
        ),
      ),
    );
  }

  Widget _nickNameTextField() {
    return TextField(
      controller: _nickNameController,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: 20,
          top: 15,
          bottom: 15,
        ),
        hintText: '닉네임을 입력해주세요',
        hintStyle: TextStyle(
          color: Color(0xFFC4C4C4),
          fontFamily: 'NanumSquareNeo-Bold',
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFFC4C4C4),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('사진 선택'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('갤러리에서 선택'),
                  onTap: () async {
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 128,
                      maxWidth: 128,
                      imageQuality: 30
                    );

                    setState(() {
                      if(image!=null) {
                        _image = File(image.path);
                      }else{
                        print('canceled');
                      }
                    });
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  child: const Text('카메라로 촬영'),
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.camera,
                        maxHeight: 128,
                        maxWidth: 128,
                      imageQuality: 30
                    );
                    setState(() {
                      if(image!=null) {
                        _image = File(image.path);
                      }else{
                        print('canceled');
                      }
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateProfile() async {
    print(accToken);
    print(refToken);
    String name = _nickNameController.text;
    if (name != '') {
      final url = Uri.http('${UrlUtil.url}:8080', '/api/v1/members/name');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'text/plain',
          'Authorization': 'Bearer $accToken',
          'x-refresh-token': 'Bearer $refToken'
        },
        body: name,
      );

      if (response.statusCode == 200) {
        print('change name success');
        await storage.write(key: 'name', value: name);
        _loadFromStorage();
      } else {
        print("change nickname error:\n${response.body}");
      }
    }

    if (_image != null) {
      print(await _image!.length());
      print((await _image!.readAsBytes()).length);
      print(_image!.path);
      print(_image!.path.split('/').last.split('.').last);

      final url = Uri.http('${UrlUtil.url}:8080', '/api/v1/members/profile');
      final request = http.MultipartRequest('POST', url);

      final originalImage = img.decodeImage(await _image!.readAsBytes());
      if (originalImage == null) {
        print('Failed to decode image');
        return;
      }

      final jpegImage = img.encodeJpg(originalImage);

      request.files.add(
          await http.MultipartFile.fromBytes(
              'file',
              jpegImage,
              filename: 'logo.jpeg',
              contentType: MediaType("image", 'jpeg')
          )
      );
      print('init file');
      request.headers.addAll({
        // 'Content-Type': 'image/${_image!.path.split('/').last.split('.').last}',
        'Authorization': 'Bearer $accToken',
        'x-refresh-token': 'Bearer $refToken',
        // 'Content-Length': '${await _image!.length()}'
      });

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('change profile success');
        var newProfileUrl = json.decode(response.body)['profile'];
        await storage.write(key: 'profile', value: newProfileUrl);
        _loadFromStorage();
      } else {
        print("change profile error:\n${response.statusCode}\n${response.body}");
      }
    }
  }
}