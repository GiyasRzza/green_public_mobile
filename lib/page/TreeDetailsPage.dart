import 'package:flutter/material.dart';

class TreeDetailsPage extends StatefulWidget {
  const TreeDetailsPage({Key? key}) : super(key: key);

  @override
  State<TreeDetailsPage> createState() => _TreeDetailsPageState();
}

class _TreeDetailsPageState extends State<TreeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(500),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                "images/treeDetails.png",
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
                  borderRadius: BorderRadius.circular(30.0),
                ),
                height: 100,
              ),
            ),

          ],
        ),
      ),
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Oak Tree", style:
                    TextStyle(color: Colors.black, fontSize: 25)),
                    Text("120 AZN", style:
                    TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 90,
                      child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(child: Text("Spring",style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold
                        ),)),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 90,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(child: Text("Summer",style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold
                        ),)),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 90,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(child: Text("Autumn",style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold
                        ),)),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 90,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(child: Text("Winter",style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold
                        ),)),
                      ),
                    ),
                  ],
                ),

              ),
              const Padding(
                padding: EdgeInsets.only(top: 10,right: 15,left: 15,bottom: 10),
                child: Expanded(
                  child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt.",overflow: TextOverflow.clip),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          "images/İcon.png",
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        Text("Watering",style: TextStyle(
                          fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                        ),),
                        Text("Day after day")
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          "images/derph.png",
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        Text("Depth",style: TextStyle(
                            fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                        ),),
                        Text("1.5 to 2.0 inches")
                      ],
                    ),
                  ],
                 ),
               ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,left: 8.0,right: 20.0,top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0,left: 8.0,right: 8.0,top: 8.0),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          "images/sun.png",
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        Text("Light",style: TextStyle(
                            fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                        ),),
                        Text("Half shade")
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          "images/soil.png",
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        Text("Soil type",style: TextStyle(
                            fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                        ),),
                        Text("Loamy")
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Planting process",style: TextStyle(fontSize: 30),),
                    SizedBox(
                      height: 25,
                    ),
                    Text("1. Cleaning the site.",style: TextStyle(fontSize: 18),),
                    Text("2. Digging a hole..",style: TextStyle(fontSize: 18),),
                    Text("3. Obtaining the plant.",style: TextStyle(fontSize: 18),),
                    Text("4. Watering the seedling.",style: TextStyle(fontSize: 18),),
                    Text("5. Removing the plant from the pot.",style: TextStyle(fontSize: 18),),
                    Text("6. Placing the plant in the hole.",style: TextStyle(fontSize: 18),),
                    Text("7. Covering the roots with soil.",style: TextStyle(fontSize: 18),),
                    Text("8. Gently packing the soil around the tree.",style: TextStyle(fontSize: 18),),
                ],),
              ),
                      Center(
                        child: SizedBox(
                          width: 400,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: Image.asset(
                                "images/video.png",
                                fit:  BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      )
            ],
          ),
        ),
      ),
    );
  }
}
