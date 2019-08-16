import 'package:flutter/material.dart';

class Partner {
  String userName;
  int userId;
  String imageUrl;
  bool isInGroup;
  bool isStar;
  Partner(this.userName,this.userId,this.isInGroup,this.imageUrl,this.isStar);
}

class Partners extends StatefulWidget {
  @override
  _Partners createState()=>_Partners();
  }

class _Partners  extends State<Partners>{

  List<Partner> _partners = [];

  @override
  void initState() {

    ///假数据
    _partners.add(Partner("ycj",0, false,"https://static.event.mihoyo.com/bh3_homepage/images/pic/picture/36.jpg",true),);
    _partners.add(Partner("syl",1, true,"https://static.event.mihoyo.com/bh3_homepage/images/pic/picture/33.jpg",false));
    _partners.add(Partner("hsl",2, true,"https://static.event.mihoyo.com/bh3_homepage/images/pic/picture/26.jpg",true));
    _partners.add(Partner("wlc",3, false,"https://static.event.mihoyo.com/bh3_homepage/images/pic/picture/27.jpg",false));
    _partners.add(Partner("zzh",4, false,"https://static.event.mihoyo.com/bh3_homepage/images/pic/picture_src/03.jpg",true));
    _partners.add(Partner("jwc",5, true,"https://static.event.mihoyo.com/bh3_homepage/images/pic/picture_src/01.jpg",true));
    _partners.add(Partner("sw",6, false,"https://static.event.mihoyo.com/bh3_homepage/images/pic/picture_src/02.jpg",false));


    super.initState();
  }

  searchPartners(String key) {

  }

  @override
  Widget build(BuildContext context) {
    Widget divider = Divider(color: Colors.black12, height: 1.0, indent: 18,);
    return Scaffold(
      appBar: AppBar(
        title: Text("Partners"),
        centerTitle: true,

      ),
      body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: Padding(
                padding: EdgeInsets.only(left: 14.0, right: 14.0),
                child: Center(
                  child: TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: 'Search'),
                    onChanged: (str) {
                      searchPartners(str);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.separated(
                  itemCount: _partners.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return divider;
                  },
                  itemBuilder: (context, index) => EachItem(_partners[index]),
                )
            )
          ],
        )
    );
  }

}
class EachItem extends StatelessWidget{

  final Partner partner;
  const EachItem(this.partner);

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child:  GestureDetector(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 14.0,right: 14.0),
                  child: new CircleAvatar(
                    backgroundImage: NetworkImage(partner.imageUrl),
                  ),
                ),
                Flexible(
                  child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5,width: 10,),
                        new Text(partner.userName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20.0
                            )
                        ),
                      ]
                  ),
                ),
              ]
          ),
          onTap: (){

          },
        ),
    );
  }
}


