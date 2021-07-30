import 'package:car_service/blocs/manager/booking/booking_bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerAccountUi extends StatefulWidget {
  // ManagerAccountUi() : super(key: key);

  @override
  _ManagerAccountUiState createState() => _ManagerAccountUiState();
}

class _ManagerAccountUiState extends State<ManagerAccountUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Thông tin tài khoản'),
      ),
      backgroundColor: Colors.blue[100],
      body: Center(
        child: BlocBuilder<VerifyBookingBloc, VerifyBookingState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.detailStatus == BookingDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == BookingDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == BookingDetailStatus.success) {
              if (state.bookingDetail != null && state.bookingDetail.isNotEmpty)
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      CircleAvatar(
                        backgroundColor: AppTheme.colors.deepBlue,
                        radius: 50,
                        child: Icon(Icons.person, size: 70,),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Change Avatar'),
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.person),
                        title: Text(state.bookingDetail[0].customer.fullname),
                      ),
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.mail),
                        title: Text(state.bookingDetail[0].customer.email),
                      ),
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.phone),
                        title:
                            Text(state.bookingDetail[0].customer.phoneNumber),
                      ),
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.place),
                        title: Text(state.bookingDetail[0].customer.address),
                      ),
                      // ListTile(
                      //   tileColor: Colors.white,
                      //   leading: Icon(Icons.edit),
                      //   title: TextFormField(
                      //     initialValue: state.userDescription,
                      //     decoration: InputDecoration.collapsed(
                      //         hintText: state.isCurrentUser
                      //             ? 'Say something about yourself'
                      //             : 'This user hasn\'t updated their profile'),
                      //     maxLines: null,
                      //     readOnly: !state.isCurrentUser,
                      //     toolbarOptions: ToolbarOptions(
                      //       copy: state.isCurrentUser,
                      //       cut: state.isCurrentUser,
                      //       paste: state.isCurrentUser,
                      //       selectAll: state.isCurrentUser,
                      //     ),
                      //     onChanged: (value) => context.read<ProfileBloc>().add(
                      //         ProfileDescriptionChanged(description: value)),
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Save Changes'),
                      ),
                    ],
                  ),
                );
              else
                return Center(child: Text('Empty'));
            } else if (state.detailStatus == BookingDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
