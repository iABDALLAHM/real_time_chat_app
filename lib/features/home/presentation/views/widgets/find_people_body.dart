import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/presentation/function/build_find_people_body_app_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_all_users_stream_cubit/get_all_users_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_all_users_stream_cubit/get_all_users_stream_states.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/users_item_list_view.dart';

class FindPeopleBody extends StatefulWidget {
  const FindPeopleBody({super.key});

  @override
  State<FindPeopleBody> createState() => _FindPeopleBodyState();
}

class _FindPeopleBodyState extends State<FindPeopleBody> {
  @override
  void initState() {
    context.read<GetAllUsersStreamCubit>().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFindPeopleBodyAppBar(),
      body: Column(
        children: [
          CustomSearchBar(hintText: "Search People"),
          Expanded(
            child: BlocBuilder<GetAllUsersStreamCubit, GetAllUsersStreamStates>(
              builder: (context, state) {
                if (state is SuccessGetAllUsersState) {
                  return UsersItemListView(usersList: state.users);
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
