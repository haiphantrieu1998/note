import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(App());
}


// I. Event : su kien co 2 nut : tang va giam
/* counter event
  enum : khai bao hang so
*/
enum CounterEvent{increment, decrement }

// II , State: trang thai dai dien la so nguyen nen k can class trang thai

/* III. Bloc : nơi nhận Events mà UI gửi qua sau đó xử lý logic
( get Data , update date ) sau đó trả về State cho UI
- Dựa vào State mà Bloc tra ve UI sẽ load lại những View cần thiết
 */

/* CounterEvent : dau vao
   int : dau ra
*/
class CounterBloc extends Bloc<CounterEvent, int>{
  @override
  // TODO: implement initialState
  // begin initial = 0
  // khoi tao gia tri cua state
  int get initialState => 0;

  // phan logic
  @override
  Stream<int> mapEventToState(CounterEvent event) async*{
    // TODO: implement mapEventToState
    switch(event){
      case CounterEvent.decrement:
        yield state -1;
        break;
      case CounterEvent.increment:
        yield state +1;
        break;
    }
  }
}
// III . UI
class CounterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // khong the thay doi gia tri cua bien final
    // cung cap 1 bloc cho cac widget con dung
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Counter'),
      ),
      /*
      - BlocBuilder là widget được sử dụng bên trong BlocProvider
       để hứng các sự thay đổi về state của bloc.

      -  Mỗi khi state thay đổi, BlocProvider sẽ thông báo
      cho các Builder để có thể render lại view theo state.

       */
      // su dung BlocBuilder tư thư viện để xây dựng lại giao diện người dùng để
      // để đáp ứng các thay đổi của trạng thái ( thay đổi tăng giảm )
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, count){
          return Center(
            child: Text(
              '$count',
              style: TextStyle(fontSize: 24.0),
            ),
          );

        }
      ),

      floatingActionButton:
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(
                  Icons.check,
              ),
              onPressed: (){
                counterBloc.add(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: (){
                counterBloc.add(CounterEvent.decrement);
              },
            ),
          )
        ],
      ),
    );
  }
}
// III . AppMain
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: CounterPage(),
      )
    );
  }
}



 


