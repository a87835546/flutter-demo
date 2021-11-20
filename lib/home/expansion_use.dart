import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpansionUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExpansionUseState();
}

class ExpansionUseState extends State<ExpansionUse> {

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("expension 可折叠的列表使用"),
      ),
      body:  FutureBuilder<List<Map<String,List<CityModel>>>>(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot<List<Map<String,List<CityModel>>>> snapshot){
            if(snapshot.hasError) {
              return Text("${snapshot.error}");
            }else {
              List<Map<String,List<CityModel>>> list = snapshot.data as List<Map<String,List<CityModel>>>;
              return  ListView.builder(itemBuilder: (BuildContext context ,int index){
                return _createView(list[index]);
              },
              itemCount: list.length,);
            }
          },
        ),
    );
  }

  Widget _createView (Map<String,List<CityModel>> map){
    List<CityModel> cities = map.values.first;
    return Container(
      child: ExpansionTile(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent
          ),
          child: Text(map.keys.first,style: TextStyle(fontSize: 20),),
        ),
        children: _createCellView(cities),
      ),
    );
  }

  List<Widget> _createCellView (List<CityModel> list) {
    return list.map((e)  {
      return ListTile(
        title: Container(
          padding: EdgeInsets.only(left: 10),
          child: Text("${e.cityName}",style: TextStyle(fontSize: 12),),
        ),
      );
    }).toList();
  }

  Future<List<Map<String,List<CityModel>>>> _getData() async {
    var dio = Dio();
    final response = await dio.get("http://192.168.1.15:9000/address/queryCites");
    final data = response.data;
    List list = [];
    try {
      list = data["data"];
    } catch (err) {
      print("解析数据出错:$err");
    }
    List<CityModel> result = [];
    list.forEach((element) {
      print("element ----- >>>>>> $element");
      result.add(CityModel.fromJson(element));
    });
    return CityModel.cityListConvertProvince(result);
  }
}

class CityModel {
  String cityName;
  String provinceName;
  String provinceCode;

  CityModel({required this.cityName, required this.provinceName,required this.provinceCode});

  static CityModel fromJson(Map<String, dynamic> json) {
    CityModel model =
    CityModel(cityName: json["name"], provinceName: json["provinceName"],provinceCode: json["provinceCode"]);
    return model;
  }

  static List<Map<String,List<CityModel>>>  cityListConvertProvince(List<CityModel> list) {
    Map<String ,List<CityModel>> map = HashMap();
    List<String> provinces = [];
    list.forEach((element) {
      !provinces.contains(element.provinceName) ? provinces.add(element.provinceName):'';
    });
    List< Map <String,List<CityModel>>> temp = [];
    for(int i = 0; i < provinces.length; i ++){
      List<CityModel> cities = [];
      list.forEach((element) {
        provinces[i] == element.provinceName ? cities.add(element) : '';
      });
      Map <String,List<CityModel>> map = HashMap();
      map[provinces[i]] = cities;
      temp.add(map);
    }
    print("temp .length ${temp.length} temp ---->>>> $temp");
    return temp;
  }
}








