import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:caps_2/widgets/sub_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _nickNameController = TextEditingController();

  XFile? _image;

  String? idx;
  String? email;
  String? name;
  String? profile;
  String? accToken;
  String? refToken;

  @override
  void initState() {
    super.initState();
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final storage = const FlutterSecureStorage();

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
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileImageStack() {
    return Column(
      children: [
        Stack(
          children: [
            profile == null
                ? Container(
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
                  )
                : ClipOval(
                    child: Image.network(
                      profile!,
                      width: 90,
                      height: 90,
                    ),
                  ),
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
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    setState(() {
                      _image = image;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  child: const Text('카메라로 촬영'),
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    setState(() {
                      _image = image;
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
}
