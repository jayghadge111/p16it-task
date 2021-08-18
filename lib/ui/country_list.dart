import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p16task/ui/res_all_countries.dart';
import 'package:p16task/ui/single_country.dart';
import 'package:p16task/ui/ui_repo.dart';

class CountryList extends StatefulWidget {
  final colorLocal;
  final region;

  CountryList({this.colorLocal, this.region});

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  final AppRepo appRepo = AppRepo();
  bool dataLoading = false;
  Color colorLocal;
  String region = "";
  List<ResAllCountries> countriesList = [];

  @override
  void initState() {
    super.initState();
    this.colorLocal = widget.colorLocal;
    this.region = widget.region;
    this.buildPageData();
  }

  buildPageData() async {
    await getAllCountriesList();
    this.dataLoading = true;
    setState(() {});
  }

  getAllCountriesList() async {
    var res = await appRepo.regionWiseCountries(region);
    if (res != null && res.statusCode == 200) {
      this.countriesList = List.generate(res.data.length, (i) {
        return ResAllCountries.fromJson(res.data[i]);
      });
      print(countriesList);
    }
  }

  navigateToNext(index){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleCountry(
          colorLocal: colorLocal,
          singleCountry: countriesList[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Countries",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: dataLoading
          ? countries()
          : Center(
              child: CircularProgressIndicator(
                color: colorLocal.withOpacity(0.7),
              ),
            ),
    );
  }

  Widget countries() {
    return Container(
      padding:
          EdgeInsets.only(right: 30.0, left: 30.0, top: 15.0, bottom: 15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: countriesList.length,
        itemBuilder: (BuildContext context, int index) {
          return singleCountry(context, index);
        },
      ),
    );
  }

  Widget singleCountry(context, index) {
    return InkWell(
      onTap: () {
        navigateToNext(index);
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            color: colorLocal.withOpacity(0.7),
            boxShadow: [
              BoxShadow(
                color: Color(0xffE7E7E7),
                blurRadius: 10.0,
                offset: Offset(0, 3),
              )
            ],
          ),
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
          margin: EdgeInsets.only(bottom: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  countriesList[index].name,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SvgPicture.network(
                countriesList[index].flag,
                width: 40,
              )
            ],
          )),
    );
  }
}
