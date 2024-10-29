import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp193/business/helpers/arguments.dart';
import 'package:pp193/business/helpers/date_helper.dart';
import 'package:pp193/business/models/diary.dart';
import 'package:pp193/presentation/themes/custom_colors.dart';
import 'package:pp193/presentation/widgets/app_text_field.dart';
import 'package:pp193/presentation/widgets/back_button.dart';

class AddDiaryView extends StatefulWidget {
  const AddDiaryView({super.key, required this.arguments});

  final AddDiaryViewArgs arguments;

  @override
  State<AddDiaryView> createState() => _AddDiaryViewState();
}

class _AddDiaryViewState extends State<AddDiaryView> {
  var buttonState = false;
  late final TextEditingController _title;
  late final TextEditingController _note;

  void _init() {
    _title = TextEditingController()..addListener(_updateButton);
    _note = TextEditingController()..addListener(_updateButton);
  }

  void _updateButton() {
    if (_title.text.isNotEmpty && _note.text.isNotEmpty) {
      setState(() {
        buttonState = true;
      });
    } else {
      setState(() {
        buttonState = false;
      });
    }
  }

  Future<void> _save() async {
    var diary = Diary(
      title: _title.text,
      note: _note.text,
      date: DateTime.now(),
    );
    await widget.arguments.controller.addDiary(diary);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    const AppBackButton(),
                    const Spacer(),
                    const SizedBox(width: 35),
                    Text(
                      'New diary',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 10,
                      onPressed: buttonState ? _save : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(buttonState ? 1 : 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Save',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 27),
                AppTextField(
                  controller: _title,
                  placeholder: 'Note title...',
                  maxLength: 128,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _note,
                  placeholder: 'Note description...',
                  maxLength: 2048,
                  smallPlaceholder: true,
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .extension<CustomColors>()!
                        .surface3!
                        .withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    DateHelper.formatDate(DateTime.now()),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
