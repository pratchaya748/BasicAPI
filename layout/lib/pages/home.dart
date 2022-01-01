import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal Knowlage"), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(builder: (context, snapshot){
          var data = json.decode(snapshot.data.toString()); //snapshot รับค่าจาก future เก็บในลักษณะ snapshot = [{},{},{}]
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return MyBox(data[index]['title'], data[index]['subtitle'], data[index]['image'], data[index]['detail']);
            },
            itemCount: data.length,);

        },
        future: DefaultAssetBundle.of(context).loadString('assets/data.json'), //ฟังก์ชันนี้จะดึงไฟล์ข้อความใน json มาวางในนี้เลย
        
        )
      ),
    );
  }

  Widget MyBox(String title,String subtitle ,String image ,String detail) {
    var v1,v2,v3,v4;
    v1 = title;
    v2 = subtitle;
    v3 = image;
    v4 = detail;

    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20.0),
      // color: Colors.amber,
      height: 200,
      decoration: BoxDecoration(
        // color: Colors.amber,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.50), BlendMode.darken)
        ),
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.7),
            offset: Offset(3,3), //ขยายออกทางแกน x,y เท่าไร
            blurRadius: 3,//รัศมีเงา
            spreadRadius: 0
          )
        ]

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, //จัดตำแหน่งในแนวตั้ง
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly, //จัดตำแหน่งในแนวตั้งให้ห่างเท่าๆกัน
        crossAxisAlignment: CrossAxisAlignment.start, //จัดตำแหน่งในแนวนอน
        children: [
          Text(
            title,
            // "คอมพิวเตอร์คืออะไร",
            style: TextStyle(fontSize: 25 ,color: Colors.white ,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15 ,color: Colors.white),
          ),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            print("next page");
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(v1,v2,v3,v4)));
          }, child: Text("อ่านต่อ", style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}
