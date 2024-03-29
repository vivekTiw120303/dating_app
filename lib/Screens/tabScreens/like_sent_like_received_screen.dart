import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';

class LikeSentLikeReceivedScreen extends StatefulWidget {
  const LikeSentLikeReceivedScreen({super.key});

  @override
  State<LikeSentLikeReceivedScreen> createState() => _LikeSentLikeReceivedScreenState();
}

class _LikeSentLikeReceivedScreenState extends State<LikeSentLikeReceivedScreen> {

  bool isLikeSentClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List likesList = [];

  getLikeKeysList() async {

    if(isLikeSentClicked){

      var likeSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("likeSent")
          .get();

      for(int i=0; i<likeSentDocument.docs.length; i++){
        likeSentList.add(likeSentDocument.docs[i].id);
      }

      getKeysDataFromUsersCollection(likeSentList);

    }
    else{

      var likeReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("likeReceived")
          .get();

      for(int i=0; i<likeReceivedDocument.docs.length; i++){
        likeReceivedList.add(likeReceivedDocument.docs[i].id);
      }

      getKeysDataFromUsersCollection(likeReceivedList);
    }
  }

  getKeysDataFromUsersCollection(List<String> keysList) async {

    var allUsersDocument = await FirebaseFirestore.instance.collection("users").get();

    for(int i=0; i<allUsersDocument.docs.length; i++){
      for(int j=0; j<keysList.length; j++){

        if((allUsersDocument.docs[i].data() as dynamic)["uid"] == keysList[j]){
          likesList.add(allUsersDocument.docs[i].data());
        }

      }
    }

    setState(() {
      likesList;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLikeKeysList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextButton(
                onPressed: (){

                  likeSentList.clear();
                  likeSentList = [];
                  likeReceivedList.clear();
                  likeReceivedList = [];
                  likesList.clear();
                  likesList = [];

                  setState(() {
                    isLikeSentClicked = true;
                  });

                  getLikeKeysList();
                },
                child: Text(
                  "My Likes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
                    color: isLikeSentClicked ? Colors.white : Colors.grey,
                  ),
                ),
              ),

              const Text(
                "   |   ",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              TextButton(
                onPressed: (){

                  likeSentList.clear();
                  likeSentList = [];
                  likeReceivedList.clear();
                  likeReceivedList = [];
                  likesList.clear();
                  likesList = [];

                  setState(() {
                    isLikeSentClicked = false;
                  });

                  getLikeKeysList();

                },
                child: Text(
                  "I'm Their Like",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isLikeSentClicked ? FontWeight.normal : FontWeight.bold,
                    color: isLikeSentClicked ? Colors.grey : Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),

        body: likesList.isEmpty
            ? const Center(
          child: Icon(
            Icons.person_off_sharp,
            size: 60,
            color: Colors.white,
          ),
        )
            : GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8),
          children: List.generate(likesList.length, (index){
            return GridTile(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Card(
                  color: Colors.blue.shade200,
                  child: GestureDetector(
                    onTap: (){

                    },

                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(likesList[index]["imageProfile"]),
                            fit: BoxFit.cover,
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const Spacer(),

                              // name - age
                              Text(
                                "${likesList[index]["name"]} ⦿ ${likesList[index]["age"]}",
                                maxLines: 2,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(
                                height: 4,
                              ),

                              // icon - city - country
                              Row(
                                children: [

                                  // location icon
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: Colors.grey,
                                  ),

                                  // city - country
                                  Expanded(
                                    child: Text(
                                      "${likesList[index]["city"]} ${likesList[index]["country"]}",
                                      maxLines: 2,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                  ),
                ),
              ),
            );
          }),
        )

    );
  }
}
