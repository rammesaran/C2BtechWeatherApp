import 'package:c2b_weatherapp/utiles/constant.dart';
import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  String cityname;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
      color: Colors.black12,
      
        
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration:kTextInputStle,
                  onChanged: (String value){
                    cityname = value.trim();                    
                  },
                   
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityname);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}