import 'package:caps_2/expense/bloc/expense_detail/expense_detail_bloc.dart';
import 'package:caps_2/expense/bloc/get_comment/get_comment_bloc.dart';
import 'package:caps_2/expense/bloc/post_comment/post_comment_bloc.dart';
import 'package:caps_2/expense/model/comment_model.dart';
import 'package:caps_2/expense/model/pin_detail_model.dart';
import 'package:caps_2/expense/view/comment_keyboard.dart';
import 'package:caps_2/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ExpenseDetailsView extends StatefulWidget {
  const ExpenseDetailsView({
    super.key,
    required this.pinIdx,
  });

  final int pinIdx;

  @override
  State<ExpenseDetailsView> createState() => _ExpenseDetailsViewState();
}

class _ExpenseDetailsViewState extends State<ExpenseDetailsView> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpenseDetailBloc()
            ..add(ExpenseDetailEvent.started(pinIdx: widget.pinIdx)),
        ),
        BlocProvider(
          create: (context) => GetCommentBloc()
            ..add(GetCommentEvent.started(pinIdx: widget.pinIdx)),
        ),
        BlocProvider(
          create: (context) => PostCommentBloc(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.more_vert, color: Colors.transparent),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<ExpenseDetailBloc, ExpenseDetailState>(
                    builder: (context, state) => state.maybeMap(
                      success: (state) => SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _LocationAndDateSelectView(
                                pinDetailModel: state.pinDetailModel,
                              ),
                              const SizedBox(height: 6),
                              _PriceView(
                                pinDetailModel: state.pinDetailModel,
                              ),
                              const SizedBox(height: 10),
                              _ContentView(pinDetailModel: state.pinDetailModel),
                              const SizedBox(height: 10),
                              const Divider(color: Colors.black, thickness: 1),
                              const _CommentListView(),
                            ],
                          ),
                        ),
                      ),
                      orElse: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
                BlocConsumer<PostCommentBloc, PostCommentState>(
                  listener: (context, state) {
                    context.read<GetCommentBloc>().add(
                          GetCommentEvent.started(pinIdx: widget.pinIdx),
                        );
                  },
                  builder: (context, state) {
                    return CommentKeyboardView(
                      textEditingController: _textEditingController,
                      onSendButtonPressed: () {
                        context.read<PostCommentBloc>().add(
                              PostCommentEvent.started(
                                pinIdx: widget.pinIdx,
                                content: _textEditingController.text,
                              ),
                            );
                        _textEditingController.clear();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationAndDateSelectView extends StatelessWidget {
  const _LocationAndDateSelectView({
    required this.pinDetailModel,
  });

  final PinDetailModel pinDetailModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              '🗓',
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'NanumSquareNeo-Bold',
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            Row(
              children: [
                Text(
                  DateFormat('yyyy-MM-dd(EEE)','ko_KR').format(pinDetailModel.createdAt),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                ),
              ],
            ),
            const SizedBox(width: 2),
            const Text(
              '의 소비 기록',
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'NanumSquareNeo-Bold',
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '✏ ${pinDetailModel.writer}님이 작성',
              style: const TextStyle(
                fontSize: 11.0,
                fontFamily: 'NanumSquareNeo-Bold',
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            if (pinDetailModel.list.isNotEmpty)
              Text(
                ' - ${pinDetailModel.writer}님 외 ${pinDetailModel.list.length - 1}명과 함께',
                style: const TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'NanumSquareNeo-Bold',
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),           
          ],
        ),
      ],
    );
  }
}

class _PriceView extends StatelessWidget {
  const _PriceView({
    required this.pinDetailModel,
  });

  final PinDetailModel pinDetailModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/frame.png',
          width: 20.0, 
          height: 20.0, 
        ),
        const SizedBox(width: 8.0),
        Text(
          '₩${_formatNumber(pinDetailModel.cost.toString())}',
          style: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'NanumSquareNeo-Bold',
            color: Colors.red,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  String _formatNumber(String value) {
    if (value.isEmpty) return ''; // 빈 문자열이면 그대로 반환
    final formatter = NumberFormat('#,###'); // 세 자리마다 쉼표(,) 추가하는 포맷
    return formatter.format(double.parse(value.replaceAll(',', '')));
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    required this.pinDetailModel,
  });

  final PinDetailModel pinDetailModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Category.getIcon(pinDetailModel.category),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pinDetailModel.title,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'NanumSquareNeo-Bold',
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 4),
              Text(
                '${pinDetailModel.createdAt.hour}:${pinDetailModel.createdAt.minute.toString().padLeft(2, '0')} | ${pinDetailModel.method}',
                style: const TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'NanumSquareNeo-Bold',
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),      
              const SizedBox(height: 4),
              if (pinDetailModel.file != null)
                Image(
                  image: NetworkImage(pinDetailModel.file ?? ''),
                  width: 160, 
                  height: 160,
                  fit: BoxFit.cover,
                ),
                const Text(
                '메모',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'NanumSquareNeo',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              if (pinDetailModel.file != null)
              Text(
                pinDetailModel.memo,
                style: const TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'NanumSquareNeo',
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CommentListView extends StatelessWidget {
  const _CommentListView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<GetCommentBloc, GetCommentState>(
        builder: (context, state) {
          return state.maybeMap(
            success: (state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '댓글',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'NanumSquareNeo-Bold',
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${state.comments.length}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'NanumSquareNeo-Bold',
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                if (state.comments.isEmpty)
                  const Center(child: Text('댓글이 없습니다.')),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    return _CommentView(comment: comment);
                  },
                ),
              ],
            ),
            orElse: () => const Row(
              children: [
                Text(
                  '댓글',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 4),
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'NanumSquareNeo-Bold',
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CommentView extends StatelessWidget {
  const _CommentView({
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(comment.profile ?? ''),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.writer,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'NanumSquareNeo-Bold',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              comment.content,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'NanumSquareNeo-Bold',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
