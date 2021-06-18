import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderDetailUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignOrderUi extends StatefulWidget {
  @override
  _AssignOrderUiState createState() => _AssignOrderUiState();
}

class _AssignOrderUiState extends State<AssignOrderUi> {
  @override
  void initState() {
    super.initState();

    context.read<AssignOrderBloc>().add(DoListAssignOrderEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: BlocBuilder<AssignOrderBloc, AssignOrderState>(
          builder: (context, state) {
            if (state.status == AssignStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == AssignStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == AssignStatus.assignSuccess) {
              if (state.assignList != null && state.assignList.isNotEmpty)
                return ListView.builder(
                  itemCount: state.assignList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.assignList[index].taiKhoan),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => AssignOrderDetailUi(
                                emailId: state.assignList[index].taiKhoan)));
                      },
                    );
                  },
                );
              else
                return Center(
                  child: Text('Empty'),
                );
            } else if (state.status == AssignStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
