import 'package:flutter/material.dart';

class BuyPage extends StatelessWidget {


  final title = ['Mini Drafter','Set Squares','Laptop Bag','Mobile','Book 1','Book 2','Book 3','Mouse'];
  final price = ['300Rs','50Rs','200Rs','15000Rs','100Rs','200Rs','150Rs','100Rs'];
  final links = ['https://www.aystationery.com/wp-content/uploads/2020/09/Omega-MINI-DRAFTER_2.png',
                 'https://cdn.onlinewebfonts.com/svg/img_8392.png',
                 'https://th.bing.com/th/id/OIP.GGA92-QnZoqtb9Tgy-LMkgHaHa?pid=ImgDet&rs=1',
                  'https://th.bing.com/th/id/OIP.HxCUDuhXiUIYR73NuIvIvQHaEp?pid=ImgDet&rs=1',
                 'https://th.bing.com/th/id/OIP.NOB2cDSQ4_qV6R40apkubwHaFT?pid=ImgDet&rs=1',
                 'https://th.bing.com/th/id/OIP.NOB2cDSQ4_qV6R40apkubwHaFT?pid=ImgDet&rs=1',
                 'https://th.bing.com/th/id/OIP.NOB2cDSQ4_qV6R40apkubwHaFT?pid=ImgDet&rs=1',
                 'https://th.bing.com/th/id/OIP.rXcAYgLQVaudqPUkgogP0gHaHa?pid=ImgDet&rs=1'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('STUFF FOR PURCHASE!',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),),
        ),
      body: PageView(
        children: [
          Center(
          child: InkWell(
            onTap: (){},
            child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: title.length,
                itemBuilder: (context,index)
              {
                return Card(
                  child: Container(
                    height: 290,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: Image.network(links[index],fit: BoxFit.fill,)),
                            Text(title[index]),
                            Row(
                              children: [
                                Text(price[index]),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0.0,
                  mainAxisExtent: 264,
                  mainAxisSpacing: 5,
                )),
          )
        ),
          SellPage(),
      ],),
    );
  }
}


class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELL STUFF',style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                      Container(
                        padding: EdgeInsets.only(top: 2,bottom: 2,left: 8,right: 8),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:Colors.pink[50],
                        ),
                      )
                    ]
                )
            ),
          ),
        ],
      ),
    );
  }
}
