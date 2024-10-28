import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:notes_bloc/cubits/language_cubit/language_cubit.dart';
import 'package:notes_bloc/cubits/user_cubit/user_cubit.dart';
import 'package:notes_bloc/data/models/user.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/shared.dart';
import 'package:notes_bloc/views/home_view.dart';
import 'package:notes_bloc/views/widgets/submit_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, this.user, this.isInitilizing = false});
  static const String id = 'editProfileView';
  final User? user;
  final bool isInitilizing;
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  int selectedAvatar = 0;
  final tc = TextEditingController();
  bool isLoading = true;

  Timer? timer;
  @override
  void initState() {
    super.initState();
    selectedAvatar = avatarCodes.indexOf(widget.user?.avatarCode ?? 15);

    timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.isInitilizing,
        title: Text(S.of(context).editProfile),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: tc,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: S.of(context).nameFieldHint,
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).chooseAvatar,
                  style: Styles.headlineLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withAlpha(50),
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(8),
                        child: Wrap(
                          children: List.generate(avatarCodes.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAvatar = index;
                                  });
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 36,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withAlpha(100),
                                      child: SvgPicture.string(
                                        multiavatar('${avatarCodes[index]}',
                                            trBackground: true),
                                        width: 72,
                                      ),
                                    ),
                                    selectedAvatar == index
                                        ? const Positioned(
                                            top: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: 14,
                                              child: Icon(
                                                Icons.check_circle_rounded,
                                                color: Colors.green,
                                              ),
                                            ))
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return SubmittButton(
                    isLoading: state is UserUpdateLoading,
                    onPressed: () async {
                      await context.read<UserCubit>().updateUser(User(
                          name: tc.text.isEmpty
                              ? widget.user?.name ?? S.current.userName
                              : tc.text,
                          avatarCode: avatarCodes[selectedAvatar]));
                      if (context.mounted) {
                        if (widget.isInitilizing) {
                          BlocProvider.of<LanguageCubit>(context).onBoard();
                          Navigator.pushReplacementNamed(context, HomeView.id);
                        } else {
                          Navigator.pop(context);
                          context.read<UserCubit>().loadUser();
                        }
                      }
                    },
                    text: S.of(context).save);
              },
            ),
          ],
        ),
      ),
    );
  }
}
