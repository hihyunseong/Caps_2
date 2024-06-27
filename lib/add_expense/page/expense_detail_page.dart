import 'dart:io';

import 'package:caps_2/add_expense/page/category_edit.dart';
import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:caps_2/common/enums/pay_method.dart';
import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/category.dart';
import '../../models/expense.dart';
import 'package:caps_2/expense/model/pin_detail_model.dart';

// 소비 기록
class ExpenseDetailPage extends StatefulWidget {
  final double amount;
  final LatLng location;
  final DateTime date;
  final String expenseLocationName;
  final MapModel mapModel;
  final List<FriendModel> selectedFriends;

  const ExpenseDetailPage({
    super.key,
    required this.amount,
    required this.location,
    required this.date,
    required this.expenseLocationName,
    required this.mapModel,
    required this.selectedFriends,
  });

  @override
  State<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  Category? _selectedCategory;
  PayMethod? _selectedPayMethod;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _contentController = TextEditingController();
  final _recordController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  XFile? _image;

  late String _recordText;

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.date;
    _recordText = DateFormat('yyyy-MM-dd').format(widget.date);
  }

  @override
  void dispose() {
    _contentController.dispose();
    _recordController.dispose();
    _additionalInfoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm').format(_selectedDate!);
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    String formattedTime = _selectedTime != null
        ? _selectedTime!.format(context)
        : formattedDateTime.split(' ')[1];

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '소비 기록',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'NanumSquareNeo-Bold',
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _locationAndDateSelectWidget(),
                  const SizedBox(height: 20.0),
                  _priceWidget(),
                  const SizedBox(height: 20.0),
                  _buildSubTitle(subTitle: '제목', isRequired: true),
                  const SizedBox(height: 10.0),
                  _titleInputWidget(),
                  const SizedBox(height: 20.0),
                  _buildSubTitle(subTitle: '결제수단'),
                  const SizedBox(height: 10.0),
                  _paymentWidget(),
                  const SizedBox(height: 20.0),
                  _buildSubTitle(subTitle: '카테고리'),
                  const SizedBox(height: 10.0),
                  _categoryWidget(),
                  const SizedBox(height: 20.0),
                  _buildSubTitle(subTitle: '사진'),
                  const SizedBox(height: 10.0),
                  _imageWidget(),
                  const SizedBox(height: 20.0),
                  _buildSubTitle(subTitle: '메모'),
                  const SizedBox(height: 10.0),
                  _memoWidget(),
                  const SizedBox(height: 80.0),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: '등록하기',
                onTap: () {
                  if (_selectedPayMethod == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('결제수단을 선택해주세요.'),
                      ),
                    );
                    return;
                  }
                  if (_selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('카테고리를 선택해주세요.'),
                      ),
                    );
                    return;
                  }

                  final mapProvider = context.read<MapProvider>();

                  if (context.read<MapProvider>().mapModel != null) {
                    if (widget.mapModel.selectedDate !=
                        mapProvider.mapModel!.selectedDate) {
                      mapProvider.changeMapModel(widget.mapModel);
                      mapProvider.saveMapModel();
                    }
                  }

                  _addExpense();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  if (widget.mapModel.isSharedMap) {
                    Navigator.pop(context);
                  }
                  Navigator.pop(context, true);
                },
                height: 70,
                color: (_contentController.text == '' ||
                        _selectedPayMethod == null ||
                        _selectedCategory == null)
                    ? Colors.red[100]!
                    : Colors.red[300]!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubTitle({required String subTitle, bool isRequired = false}) {
    if (isRequired) {
      return Row(
        children: [
          Text(
            subTitle,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'NanumSquareNeo-Bold',
            ),
          ),
        ],
      );
    }
    return Text(
      subTitle,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w900,
        fontFamily: 'NanumSquareNeo-Bold',
      ),
    );
  }

  Widget _locationAndDateSelectWidget() {
    return Row(
      children: [
        Text(
          '📍',
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          widget.expenseLocationName,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'NanumSquareNeo-Bold',
          ),
        ),
        const Text(
          ' 에서',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'NanumSquareNeo-Bold',
            color: Colors.grey,
          ),
        ),
        Text(
          '🗓',
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(width: 2),
        InkWell(
          onTap: () {
            // _editRecord();
            _selectDate(context);
          },
          child: Row(
            children: [
              Text(
                _recordText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'NanumSquareNeo-Bold',
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     _selectDate(context);
              //   },
              //   icon: const Icon(Icons.calendar_today),
              // ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          '의 소비 기록',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'NanumSquareNeo-Bold',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _priceWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/frame.png',
          width: 24.0, 
          height: 24.0, 
        ),
        const SizedBox(width: 8.0),
        Text(
          '₩ ${_formatNumber(widget.amount.toString())}',
          style: const TextStyle(
            fontSize: 16.0,
            fontFamily: 'NanumSquareNeo-Bold',
            color: Colors.red,
            ),
          ),
        ],
      );
    }

  Widget _titleInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: TextField(
            controller: _contentController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 20,
                top: 15,
                bottom: 15,
              ),
              hintText: '제목을 입력해 주세요.',
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
          ),
        ),
      ],
    );
  }

  Widget _paymentWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _paymentCard(PayMethod.creditCatd),
          const SizedBox(width: 10),
          _paymentCard(PayMethod.checkCard),
          const SizedBox(width: 10),
          _paymentCard(PayMethod.cash),
          const SizedBox(width: 10),
          _paymentCard(PayMethod.accountTransfer),
        ],
      ),
    );
  }

  Widget _paymentCard(PayMethod payMethod) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayMethod = payMethod;
        });
      },
      child: _selectedPayMethod == payMethod
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red),
              ),
              child: Text(
                payMethod.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                payMethod.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
    );
  }

  Widget _categoryWidget() {
    final categories = context.watch<MapProvider>().activeCategories;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (final category in categories) ...[
            _buildIconButton(category),
            const SizedBox(width: 3.0),
          ],
          Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryEdit()),
                  );
                },
                icon: Image.asset(
                  'assets/images/category/plus.png',
                  width: 40,
                  height: 40,
                ),
              ),
              const Text(
                '편집',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'NanumSquareNeo-Bold',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageWidget() {
    return Row(
      children: [
        if (_image != null) ...[
          Image.file(
            File(_image!.path),
            width: 60,
            height: 60,
          ),
          const SizedBox(width: 10),
        ],
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              _showImagePickerDialog(context);
            },
            icon: const Icon(
              Icons.add_a_photo_outlined,
              color: Colors.grey,
            ),
            iconSize: 32.0,
          ),
        ),
      ],
    );
  }

  Widget _memoWidget() {
    return SizedBox(
      height: 120,
      child: Expanded(
        child: TextField(
          controller: _additionalInfoController,
          onChanged: (value) {
            setState(() {});
          },
          expands: true,
          minLines: null,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          decoration: const InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            hintText: '메모를 입력해 보세요.',
          ),
        ),
      ),
    );
  }

  void _addExpense() {
    // 날짜와 시간을 합친다.
    final date = _selectedDate ?? DateTime.now();
    final time = _selectedTime ?? TimeOfDay.now();

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute, 
    );

    final expense = Expense(
      expenseLocationName: widget.expenseLocationName,
      amount: widget.amount,
      category: _selectedCategory ?? Category.etc,
      content: _contentController.text,
      memo: _additionalInfoController.text,
      date: dateTime,
      imagePath: _image?.path,
      latitude: widget.location.latitude,
      longitude: widget.location.longitude,
      map: widget.mapModel,
      payMethod: _selectedPayMethod ?? PayMethod.none,
      createdAt: DateTime.now(),
      friends: widget.selectedFriends,
    );
    
    final mapProvider = context.read<MapProvider>();
    mapProvider.addExpense(expense, widget.mapModel.isSharedMap);
  }

 Widget _buildIconButton(Category category) {
  return Column(
    children: [
      Transform.translate(
        offset: _selectedCategory == category ? Offset(0, -6) : Offset(0, 0),
        child: IconButton(
          onPressed: () {
            setState(() {
              _selectedCategory = category;
            });
          },
          icon: Image.asset(
            category.iconPath,
            width: 40,
            height: 40,
          ),
          iconSize: 32.0,
        ),
      ),
      Text(
        category.text,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'NanumSquareNeo-Bold',
        ),
      ),
    ],
  );
}

    // return Column(
    //   children: [
    //     IconButton(
    //       onPressed: () {
    //         setState(() {
    //           _selectedCategory = category;
    //         });
    //       },
    //       icon: Icon(icon, size: _selectedCategory == category ? 30 : 15),
    //       iconSize: 32.0,
    //     ),
    //     Text(label),
    //   ],
    // );
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _recordText = DateFormat('yyyy-MM-dd').format(picked);
      });

      _selectTime(context);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

// 클릭하면 20xx-xx-xx의 기록 제목변경
  void _editRecord() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            controller: _recordController,
            decoration: const InputDecoration(hintText: '내용입력'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _recordText = _recordController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('저장'),
            ),
          ],
        );
      },
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('사진/동영상 선택'),
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
                    if (image != null) {
                      // 이미지가 선택된 경우 이를 처리하는 로직을 작성
                      // 예를 들어, 이미지를 보여주거나 업로드하는 등의 작업을 수행
                      // image 변수에 선택된 이미지 파일이 저장됩니다.
                      setState(() {
                        _image = image;
                      });
                    }
                    Navigator.of(context).pop(); // 다이얼로그 닫기
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
                    if (image != null) {
                      setState(() {
                        _image = image;
                      });
                    }
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatNumber(String value) {
    if (value.isEmpty) return ''; // 빈 문자열이면 그대로 반환
    final formatter = NumberFormat('#,###'); // 세 자리마다 쉼표(,) 추가하는 포맷
    return formatter.format(double.parse(value.replaceAll(',', '')));
  }
}