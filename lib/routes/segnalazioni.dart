import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sit_lb_2021/routes/drawer.dart';

class Segnalazioni extends StatefulWidget {
  @override
  _SegnalazioniState createState() => _SegnalazioniState();
}

class _SegnalazioniState extends State<Segnalazioni> {
  final _advancedDrawerController = AdvancedDrawerController();

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'S',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'IT',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' Segnalazioni ',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (context, value, child) {
                return Icon(
                  value.visible ? Icons.clear : Icons.menu,
                );
              },
            ),
          ),
        ),
        body: Container(
            color: Colors.blueGrey,


          child: Column(
            children: [
              Container(padding: EdgeInsets.all(30),
                child: _title(),
              ),
              Container(
                margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Order("11 gennaio","191", "Lorenzo", "Borelli", "12", "scarico rifiuti"),
                      Order("11 gennaio","191", "Lorenzo", "Borelli", "12", "scarico rifiuti"),
                      Order("11 gennaio","191", "Lorenzo", "Borelli", "12", "scarico rifiuti"),

                    ],
                  ),
                ),
              ),

            ],
          )

        ),
      ),
      drawer: MyDrawer(),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  Widget Order(dynamic date, dynamic numberorder, dynamic name, dynamic surname,
      dynamic price, dynamic status) {
    return GestureDetector(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: 138,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${date}',
                      style: TextStyle(
                        color: Color(0xFF989898),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "#" + "$numberorder",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "$name" + " $surname",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat",
                        ),
                        maxLines: 2,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            "$price" + "€",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 140,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Color(0xFFa5e5d1),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                                child: Text(
                              "$status",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFF989898),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap:() {},
    );
  }
}
