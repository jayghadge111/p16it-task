import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p16task/ui/res_all_countries.dart';

class SingleCountry extends StatefulWidget {
  final singleCountry;
  final colorLocal;

  SingleCountry({this.singleCountry, this.colorLocal});

  @override
  _SingleCountryState createState() => _SingleCountryState();
}

class _SingleCountryState extends State<SingleCountry> {
  ResAllCountries singleCountry;
  Color colorLocal;

  @override
  void initState() {
    super.initState();
    this.singleCountry = widget.singleCountry;
    this.colorLocal = widget.colorLocal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          singleCountry.region + "/" + singleCountry.name,
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: countryDetails(),
    );
  }

  Widget countryDetails() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      // height: double.infinity,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        color: colorLocal.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Color(0xffE7E7E7),
            blurRadius: 10.0,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.network(
                singleCountry.flag,
                width: 60,
                height: 40,
              ),
              SizedBox(width: 20),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: singleCountry.name +
                            " (${singleCountry.alpha3Code})" +
                            "\n",
                        style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                          text: singleCountry.capital,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: richTextCard1(
                    (singleCountry.demonym != null &&
                            singleCountry.demonym != "")
                        ? singleCountry.demonym
                        : "-",
                    "Demonym"),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: richTextCard1(
                    (singleCountry.callingCodes[0] != null &&
                            singleCountry.callingCodes[0] != "")
                        ? singleCountry.callingCodes[0]
                        : "-",
                    "Calling Code"),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: richTextCard1(
                    ((singleCountry.currencies[0].symbol != null &&
                                singleCountry.currencies[0].symbol != "")
                            ? singleCountry.currencies[0].symbol
                            : "-") +
                        " " +
                        ((singleCountry.currencies[0].name != null &&
                                singleCountry.currencies[0].name != "")
                            ? singleCountry.currencies[0].name
                            : "-"),
                    "Currency"),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: richTextCard1(
                    (singleCountry.population.toString() != null &&
                            singleCountry.population.toString() != "")
                        ? singleCountry.population.toString()
                        : "_",
                    "Population"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget richTextCard1(String title, String value) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey),
          left: BorderSide(width: 1.0, color: Colors.grey),
          right: BorderSide(width: 1.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title + "\n",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            TextSpan(
                text: value,
                style: TextStyle(
                    fontSize: 14.0, color: Colors.grey[700], height: 1.5)),
          ],
        ),
      ),
    );
  }
}
