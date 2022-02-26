import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/routes/search_routeEntity.dart';
import '../commonEntity/countryEntity.dart';
import '../commonLogic/commonUI.dart';
import 'friendProfile.dart';
import 'SearchConditionPage.dart';



class Search extends ConsumerWidget {
  Search({
    Key? key,
  }) : super(key: key);

  bool searchProcessFlg=true;



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
        appBar: whiteAppbar(text:(ref.watch(SearchResultProvider).searchResultList==null)?"Search":"Search"),//
        body: SafeArea(
            child:Padding(padding:const EdgeInsets.only(top:14,left:14,right:14,bottom:10),
              child:Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Container(
                      height: 42,
                      child:Row(
                        children:[
                          Expanded(
                      child:Container(
                            child:Padding(
                              padding:const EdgeInsets.symmetric(horizontal:13),
                              child:Row(
                              children:[Align(
                                alignment:Alignment.centerLeft
                                ,child:Text("set conditions",
                              style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.deepOrangeAccent,
                            ),
                            )),
                                Expanded(
                                  child:Align(
                                        alignment:Alignment.centerRight
                                        ,child:GestureDetector(
                                    onTap: () async{
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return SearchConditionPage(
                                          );
                                        }),
                                      );

                                      ref.watch(SearchResultProvider.notifier).userSearch(ref);
                                    },
                                    child: Icon(
                                        Icons.view_headline_sharp,
                                        color: Colors.deepOrangeAccent,
                                        size:26
                                    )
                                )
                                  ),
                                )
                              ],),),
                            decoration: BoxDecoration(
                              color:Color.fromRGBO(	252,217,151, 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),),
                          Container(
                            width:40,
                          child:Align(
                              alignment:Alignment.center,
                              child:GestureDetector(
                                  onTap: () async{
                                    ref.watch(SearchResultProvider.notifier).userSearch(ref);
                                  },
                                  child: Icon(
                                      Icons.search,
                                      color: Colors.black87,
                                      size:26
                                  )
                              )
                          ))
                        ]
                      )
                    ),
                  ),
                  resultBody(ref)
                ]
              )
            )
        )
    );
  }

  Widget resultBody(WidgetRef ref){

    if(searchProcessFlg==true) {
      searchProcessFlg=false;
      ref.watch(SearchResultProvider.notifier).clear();
      ref.watch(SearchResultProvider.notifier).userSearch(ref);
      return Expanded(
          child:Center(
          child:
      CircularProgressIndicator()
      )
      );
    }else {
      return Expanded(
          child:ListView.builder(
              itemCount:ref.watch(SearchResultProvider).searchResultList.length,
              itemBuilder:(BuildContext context,int index){
                return userResultList( context,  ref,ref.watch(SearchResultProvider).searchResultList[index]);
              }
          ));
    }
  }

  Widget userResultList(BuildContext context, WidgetRef ref,AlgoliaObjectSnapshot userData){

    String lastLoginStr="";
    //最終ログイン日付の計算
    int differentDays =DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(userData.data["lastLoginTime"])).inDays;
    if(differentDays==0){
      lastLoginStr="today";
    }else if(differentDays == 1){
      lastLoginStr="yesterday";
    }else{
      lastLoginStr=differentDays.toString()+" days ago";
    }

    List<Widget> featureList=[];
    featureList.add(orangeBorderContainer( text:"intermediate"));
    featureList.add(orangeBorderContainer( text:"cate1"));
    featureList.add(orangeBorderContainer( text:"cate2"));
    featureList.add(orangeBorderContainer( text:"cate3"));
    featureList.add(orangeBorderContainer( text:"cate4"));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5),
      child: GestureDetector(
        onTap:()async{
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return FriendProfile(
                  argumentFriendUserDocId:userData.data["objectID"],
              );
            }),
          );
        },
        child: Container(
          color: Colors.white10,
          height:130,
          child:Row(
            children:[
              Container(
                child:CircleAvatar(radius:32,
              backgroundImage:ref.watch(SearchResultProvider).friendImage[userData.data["objectID"]] ==null
              ? null
              : ref.watch(SearchResultProvider).friendImage[userData.data["objectID"]]!.image,),
                    width:80
              ),
              Expanded(
                child:Column(
                  children:[
                    Row(children:[
                      blackBiggerTextLeft(text: userData.data["name"]),
                CircleAvatar(radius:10,
                    backgroundImage:ref.watch(countryDataProvider).countryData[userData.data["country"]]["imageFile"].image)
                    ]),
                    grayTextLeft(text: userData.data["greeting"]),
                    Wrap(children: featureList)
                  ],
                )
              ),
              Container(
                  width:70,
                child:Column(
                  children:[
                    grayTextRight(text:lastLoginStr ),
                  ]
                )
              )
            ]
          )
        ),
      ),
    );
  }
}