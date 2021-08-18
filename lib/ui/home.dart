import 'package:flutter/material.dart';
import 'package:p16task/ui/country_list.dart';
import 'package:p16task/ui/ui_repo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AppRepo appRepo = AppRepo();
  bool dataLoading = false;

  List continentList = [
    {
      "name": "Asia",
      "color": Colors.blueAccent,
    },
    {
      "name": "Europe",
      "color": Colors.deepPurple,
    },
    {
      "name": "Africa",
      "color": Colors.cyan,
    },
    {
      "name": "Oceania",
      "color": Colors.blue,
    },
    {
      "name": "Americas",
      "color": Colors.deepPurpleAccent,
    },
    {
      "name": "Polar",
      "color": Colors.teal,
    }
  ];

  @override
  void initState() {
    super.initState();
    this.buildPageData();
  }

  buildPageData() async {
    await getAllCountriesData();
    this.dataLoading = true;
    setState(() {});
  }

  getAllCountriesData() async {
    var res = await appRepo.countriesData();
    if (res != null && res.statusCode == 200) {
      print(res);
    }
  }

  navigateToNext(index){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryList(
          colorLocal: continentList[index]['color'],
          region: continentList[index]['name'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Region", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: dataLoading
          ? continent()

          : Center(
              child: CircularProgressIndicator(color: Colors.teal,),
            ),
    );
  }

  Widget continent() {
    return Container(
      padding:
          EdgeInsets.only(right: 30.0, left: 30.0, top: 20.0, bottom: 15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: continentList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return singleContinent(context, index);
        },
      ),
    );
  }

  Widget singleContinent(context, int index) {
    return InkWell(
      onTap: () {
        navigateToNext(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          color: continentList[index]['color'],
          boxShadow: [
            BoxShadow(
              color: Color(0xffE7E7E7),
              blurRadius: 10.0,
              offset: Offset(0, 3),
            )
          ],
        ),
        padding:
            EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Text(
            continentList[index]['name'],
            textScaleFactor: 1.0,
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
