import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:notes_bloc/cubits/user_cubit/user_cubit.dart';
import 'package:notes_bloc/shared.dart';
import 'package:notes_bloc/views/edit_profile_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is UserLoadLoading,
          child: SizedBox(
            width: double.maxFinite,
            height: 180,
            child: Stack(
              children: [
                Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(100),
                        child: state is UserloadSuccess
                            ? SvgPicture.string(multiavatar(state.user.avatar,
                                trBackground: true))
                            : const CircleAvatar(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(state is UserloadSuccess ? state.user.name : '',
                        style: Styles.headlineLarge)
                  ],
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            final userCubit =
                                BlocProvider.of<UserCubit>(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                          value: userCubit,
                                          child: const EditProfileView(),
                                        )));
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 30,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
