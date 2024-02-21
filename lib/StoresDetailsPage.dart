import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoresDetailsPage extends StatefulWidget {
  const StoresDetailsPage({Key? key}) : super(key: key);

  @override
  State<StoresDetailsPage> createState() => _StoresDetailsPageState();
}

class _StoresDetailsPageState extends State<StoresDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(500),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                "images/storDetails.png",
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: -60,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0), // Değerini artırarak daha fazla yuvarlaklık elde edebilirsiniz
                ),
                height: 100,
              ),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: 600,
          child:  Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 80,
                              child: Image.asset(
                                "images/stores.png",
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                           const Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Green Public", style:
                               TextStyle(color: Colors.black, fontSize: 20)),
                               Text("Monday - Friday / 9 a.m. - 5 p.m.",
                                   softWrap: true,overflow: TextOverflow.clip,
                                   style: TextStyle(color: Colors.black26, fontSize: 15)),
                             ],
                           ),
                            const Text("3.41 km.", style: TextStyle(color: Colors.black, fontSize: 15)),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.",
                            overflow: TextOverflow.visible,
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.phone),
                            SizedBox(
                              width: 5,
                            ),
                            Text("+994552025873")
                          ],
                        ),
                      ),
                     const Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Row(
                         children: [
                           Icon(Icons.location_on,color: Colors.blueAccent,),
                           SizedBox(
                             width: 5,
                           ),
                           Text("South Aspen St.Manassas, VA 20109.",
                               overflow: TextOverflow.visible,
                               style: TextStyle(color: Colors.blueAccent, fontSize: 15)),
                         ],
                       ),
                     ),
                       Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black45,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Trees",
                                overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.black45, fontSize: 20),
                              ),
                            ),
                            const Text("Care products",
                                overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.black45, fontSize: 20)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.search_sharp,size: 35,color: Colors.black45,),
                              ),
                              Text("Search",style: TextStyle(color:Colors.black45,fontSize: 25),),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: SizedBox(
                          height: 200,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 300,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: Colors.white12.withOpacity(0.8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "images/tree.png",
                                        ),
                                        const Align( alignment: Alignment.centerLeft ,child: Text("Oak Tree",style: TextStyle(color: Colors.black,fontSize: 20),)),
                                        const Expanded(child: Text("Lorem ipsum dolor sit consectetur adipiscing elit.",style:
                                        TextStyle(color: Colors.black),softWrap: true,overflow:TextOverflow.ellipsis )),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Expanded(child: Text("120 Azn.",style:
                                          TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
