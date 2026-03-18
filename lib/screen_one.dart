import 'package:flutter/material.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  TextEditingController mytxt1 = TextEditingController();
  TextEditingController mytxt2 = TextEditingController();
  var gstamount = 0;
  var amout1 = 0;
  var myans = "";
   var myans2 = "";
   dynamic sgst=0;
   dynamic cgst=0;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: SafeArea(
          child:
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0)
              ),
              child:Column(
              children: [
                //for Amout label on textfield
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Amout",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: mytxt1,
                   decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0  
                      )
                    )
                   ),
                 
                  ),
                ),
                //for GST label on textfield
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("GST rate %",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  )),
                
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: mytxt2 ,
                   decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0  
                      )
                    )
                   ),
                  ),
                  
                ),
        
                //select include or exclude GST
                Column(
                  children: [
                    RadioListTile(value:false, groupValue: isChecked, onChanged: ( value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },  
                    title: Text("Include GST"),
                    ),
                    RadioListTile(value:  true, groupValue: isChecked, onChanged: ( value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },  
                    title: Text("Exclude GST"),
                    ),
                  ],
                ),
                Text("")
            ,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed:() {
                  doCalculatePercentage();
                }, child: Text("Click",style: TextStyle(color: Colors.white),)),
               SizedBox(
                height: 50,
               ),
        
               //show result container
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.shade500,
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                     
                      children:[
                        //for CGST
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Amout of CGST:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text("${cgst}",style:TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        //for SGST
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Amout of SGST:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text("${sgst}",style:TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Amout of GST:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text("${myans2}",style:TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Net Amout:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text("${myans}",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                 ),
               )
        
              ],
            )
            ),
          ),
        )),
      ),
    );
  }

  void doCalculatePercentage(){
    var a = mytxt1;
    var b = mytxt2;
    var amout=int.parse(a.text);
    var rate=int.parse(b.text);

    


    if(isChecked==false){
      //exclude GST
      var gstamount = (amout*rate~/100);
      var Sgst = gstamount/2;
      var Cgst = gstamount/2;
      var netamout = amout + gstamount + Sgst + Cgst;
      
      setState(() {
        myans = netamout.toString();
        myans2 = gstamount.toString();
        sgst = Sgst;
        cgst = Cgst;
      });
    }else{
      //include GST 
      gstamount = (amout*rate~/ (100 + rate));
      var Sgst = gstamount/2;
      var Cgst = gstamount/2;
      var netamout = amout - gstamount - Sgst - Cgst;
       
      setState(() {
        myans = netamout.toString();
        myans2 = gstamount.toString();
        sgst = Sgst;
        cgst = Cgst;
      });

    }
  }
}