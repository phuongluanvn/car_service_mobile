// import 'package:car_service/ui/Customer/carCard.dart';
import 'package:car_service/blocs/customer_car/customerCar_bloc.dart';
import 'package:car_service/blocs/customer_car/customerCar_event.dart';
import 'package:car_service/blocs/customer_car/customerCar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  CustomerCarBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CustomerCarBloc>(context);
    bloc.add(DoFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCarBloc, CustomerCarState>(
      builder: (context, state) {
        if (state is InitCustomerCarState) {
          return CircularProgressIndicator();
        } else if (state is LoadingState) {
          return CircularProgressIndicator();
        } else if (state is FetchSuccess) {
          return ListView.builder(
              itemCount: state.cars.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => Container(
                    width: 5.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  color: Colors.white10,
                                  child: Image.asset("lib/images/e.jpg"),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(state.cars[index].tenPhim,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      state.cars[index].moTa,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
        } else if (state is ErrorState) {
          return ErrorWidget(state.mess.toString());
        }
      },
    );
  }
}

// class Home extends StatelessWidget {
//   List name = ["ahihi", "huhuhu", "lalala"];
//   List des = ["lalalal", "aakasksld", "kakaka"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//           itemCount: name.length,
//           shrinkWrap: true,
//           itemBuilder: (BuildContext context, int index) => Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                 child: Card(
//                   elevation: 5.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(0.0),
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                               width: 55.0,
//                               height: 55.0,
//                               color: Colors.green,
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.green,
//                                 foregroundColor: Colors.green,
//                                 backgroundImage: NetworkImage(
//                                     "https://www.google.com/url?sa=i&url=https%3A%2F%2Fduetngyen.wordpress.com%2F2015%2F06%2F11%2Ffloat-trong-css%2F&psig=AOvVaw1wqhxgQJkLjrcx3lycfGLK&ust=1622805319790000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODkrIer-_ACFQAAAAAdAAAAABAN"),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5.0,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(name[index],
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 18.0,
//                                         fontWeight: FontWeight.bold)),
//                                 Text(des[index],
//                                     style: TextStyle(color: Colors.grey)),
//                               ],
//                             )
//                           ],
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 10.0, vertical: 10.0),
//                           child: FlatButton(
//                             onPressed: () {},
//                             color: Colors.red[200],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child: Text("Invite",
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//     );
//   }
// }
