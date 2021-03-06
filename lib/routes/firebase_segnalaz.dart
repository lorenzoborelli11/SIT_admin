import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController searchcontroller = TextEditingController();

  Widget _searchField( TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      width: 140,
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.blueGrey,
                    onPressed: () {},
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(45.0),
                    ),
                  ),
                  fillColor: Color(0xfff3f3f4),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      borderSide: BorderSide(
                        color: Colors.red.shade900,
                      )),
                  labelStyle: new TextStyle(
                    color: Colors.red.shade900,
                  ),
                  filled: true))
        ],
      ),
    );
  }



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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
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
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('segnalazioni').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      color: Colors.blueGrey,
                      child: Column(
                        children: [
                          Container(padding: EdgeInsets.only(left:width * 0.1+ 20, right: width * 0.1 + 20, top: 30, bottom: 30),
                            child: Row(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: _title()),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: _searchField(searchcontroller),),
                                ),

                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                              padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                              decoration: BoxDecoration(

                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                              ),
                              child: ListView(
                                  shrinkWrap: true,
                                children: snapshot.data.docs.map((DocumentSnapshot document)  {
                                  return Order( getDate(document["date"].toString()), document.id, "", document["coordlat"], document["coordlong"] , "", document["type"], document["descriz"]);
                               }).toList(),
                                  ),
                            ),
                          ),

                        ],
                      )

                  ),
                  Container(
                    height: 50,
                    color: Colors.blueGrey,
                  ),
                ],
              ),


            );

      },
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

  getDate(String data) {

      return data.substring(0, 16);
  }



  Widget Order(String date, dynamic numberorder, dynamic name, dynamic lat, dynamic long,
      dynamic price, dynamic status, dynamic descrizione,) {
    return GestureDetector(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
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
                        "$name",
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
                          child: IconButton(
                            icon: Icon(Icons.delete_forever),
                            iconSize: 35,
                            color: Colors.blueGrey,
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("segnalazioni")
                                  .get().then((value){
                                  FirebaseFirestore.instance.collection("segnalazioni").doc(numberorder).delete().then((value){
                                    print("Deleted document with Successo!");
                                  });
                                });
                              }),

                          ),
                        ),


                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Coordinate:[' + " Lat: " "${lat}" " Long: " "${long}" "]",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                      ),
                    ),),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
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
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Descrizione: ' + "${descrizione}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                      ),
                    ),),
                  SizedBox(height: 10,),
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
