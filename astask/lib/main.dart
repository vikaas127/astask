import 'package:astask/API/Apicall.dart';
import 'package:astask/model/State_model.dart' as s;
import 'package:astask/model/city_model.dart' as c;
import 'package:flutter/material.dart';
import 'model/country_model.dart' ;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Api _api = Api();
  bool loading=false;
  int _counter = 0;
  country_model ?countrymodel;
  List<Result> _list=  [];
  List<s.Result>_slist=[];
  List<c.Result>_clist=[];
  TextEditingController County_controller = TextEditingController();
  TextEditingController City_controller = TextEditingController();
  TextEditingController State_controller = TextEditingController();
  @override
  void initState() {

    Api().CountryRequest().then((value) {setState(() {
      _list.addAll(value.result!);
      loading=true;
    });
    } );

    super.initState();

  }
  Future<s.state_model> CallApi_stateList(_body) async {
    s.state_model response;

    Map<String, dynamic> body =_body;

      response = await Api().StateRequest(body);

      setState(() {
      print(" ${response.result![0].toString()}");
        _slist.addAll(response.result!);
        loading=true;
      });


    return response;
  }

Result ?_countySelectedValue;
  s.Result ?_stateSelectedValue;
  c.Result ?_citySelectedValue;
  Future<c.city_model> CallApi_cityList(_body) async {
    c.city_model response;

    Map<String, dynamic> body =_body


    ;

    response = await Api().CityRequest(body);

    setState(() {

      _clist.addAll(response.result!);
      loading=true;
    });


    return response;
  }
  @override
  Widget build(BuildContext context) {
   Size size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(child:loading==true?  ListView(scrollDirection: Axis.vertical,shrinkWrap: true,
    children: [
      SizedBox(height:size .height*0.05,),
      //county

    FormField<Result>(
    builder: (FormFieldState<Result> state) {
    return InputDecorator(
    decoration: InputDecoration(

    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
    hintText: 'Please select expense',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    isEmpty: _countySelectedValue == '',
    child: DropdownButtonHideUnderline(
    child: DropdownButton<Result>(
    value: _countySelectedValue,
    isDense: true,
    onChanged: (Result ?newValue) {
    setState(() {
      _countySelectedValue = newValue!;
      loading=false;
      _slist.clear();
      _clist.clear();
      CallApi_stateList(  { "CountryID": "${newValue.countryID}"});

    //state.didChange(newValue);
    });
    },
    items: _list.map((Result value) {
    return DropdownMenuItem<Result>(
    value: value,
    child: Text(value.countryName!),
    );
    }).toList(),
    ),
    ),
    );}),
      SizedBox(height: 20,),
      FormField<s.Result>(
          builder: (FormFieldState<s.Result> state) {
            return InputDecorator(
              decoration: InputDecoration(

                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              isEmpty: _stateSelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<s.Result>(
                  value: _stateSelectedValue,
                  isDense: true,
                  onChanged: (s.Result ?newValue) {
                    setState(() {
                      _stateSelectedValue = newValue!;
                      state.didChange(newValue);
                      loading=false;
                      CallApi_cityList( {"StateID":newValue.iD});
                    });
                  },
                  items: _slist.map((s.Result value) {
                    return DropdownMenuItem<s.Result>(
                      value: value,
                      child: Text(value.name!),
                    );
                  }).toList(),
                ),
              ),
            );}),
      SizedBox(height: 20,),
      FormField<c.Result>(
          builder: (FormFieldState<c.Result> state) {
            return InputDecorator(
              decoration: InputDecoration(

                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              isEmpty: _citySelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<c.Result>(
                  value: _citySelectedValue,
                  isDense: true,
                  onChanged: (c.Result ?newValue) {
                    setState(() {
                      _citySelectedValue = newValue!;
                      state.didChange(newValue);
                    });
                  },
                  items: _clist.map((c.Result value) {
                    return DropdownMenuItem<c.Result>(
                      value: value,
                      child: Text(value.name!),
                    );
                  }).toList(),
                ),
              ),
            );}),

    ],
    ):Center(child: CircularProgressIndicator(color: Colors.blue,)),



    ));
  }
}
