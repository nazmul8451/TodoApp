import 'package:flutter/material.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Water Tracker",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow:
                  [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]),
              child: Column(
                children: [
                  Text(
                    "Today's InTank",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,),),
                  SizedBox(height: 10,),
                  Text('SomeThing',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueAccent,
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //Stack IS my new Learning Widgets so this widgets is clear be,

            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    // value: ,
                    backgroundColor: Colors.grey,
                    color: Colors.blueAccent,
                    strokeWidth: 10,
                  ),
                ),
                Text(
                  '0%',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                ),
              ],
            ),


            SizedBox(
              height: 40,
            ),

            Wrap(
              spacing: 20,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: (){},
                        label: Text('AddWater 200ML',style: TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.w600,
                        ),),
                        icon: Icon(Icons.water_drop)
                    ),
                  ),
                )
              ],
            )




          ],
        ),
      ),
    );
  }
}
