import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';

class ViewSentViewReceivedScreen extends StatefulWidget {
  const ViewSentViewReceivedScreen({super.key});

  @override
  State<ViewSentViewReceivedScreen> createState() => _ViewSentViewReceivedScreenState();
}

class _ViewSentViewReceivedScreenState extends State<ViewSentViewReceivedScreen> {

  bool isViewSentClicked = true;
  List<String> viewSentList = [];
  List<String> viewReceivedList = [];
  List viewsList = [];

  getViewKeysList() async {

    if(isViewSentClicked){

      var viewSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("viewSent")
          .get();

      for(int i=0; i<viewSentDocument.docs.length; i++){
        viewSentList.add(viewSentDocument.docs[i].id);
      }

      getKeysDataFromUsersCollection(viewSentList);

    }
    else{

      var viewReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("viewReceived")
          .get();

      for(int i=0; i<viewReceivedDocument.docs.length; i++){
        viewReceivedList.add(viewReceivedDocument.docs[i].id);
      }

      getKeysDataFromUsersCollection(viewReceivedList);
    }
  }

  getKeysDataFromUsersCollection(List<String> keysList) async {

    var allUsersDocument = await FirebaseFirestore.instance.collection("users").get();

    for(int i=0; i<allUsersDocument.docs.length; i++){
      for(int j=0; j<keysList.length; j++){

        if((allUsersDocument.docs[i].data() as dynamic)["uid"] == keysList[j]){
          viewsList.add(allUsersDocument.docs[i].data());
        }

      }
    }

    setState(() {
      viewsList;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getViewKeysList();
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

                  viewSentList.clear();
                  viewSentList = [];
                  viewReceivedList.clear();
                  viewReceivedList = [];
                  viewsList.clear();
                  viewsList = [];

                  setState(() {
                    isViewSentClicked = true;
                  });

                  getViewKeysList();
                },
                child: Text(
                  "Profiles I Viewed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isViewSentClicked ? FontWeight.bold : FontWeight.normal,
                    color: isViewSentClicked ? Colors.white : Colors.grey,
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

                  viewSentList.clear();
                  viewSentList = [];
                  viewReceivedList.clear();
                  viewReceivedList = [];
                  viewsList.clear();
                  viewsList = [];

                  setState(() {
                    isViewSentClicked = false;
                  });

                  getViewKeysList();

                },
                child: Text(
                  "My Profiles Viewed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isViewSentClicked ? FontWeight.normal : FontWeight.bold,
                    color: isViewSentClicked ? Colors.grey : Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),

        body: viewsList.isEmpty
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
          children: List.generate(viewsList.length, (index){
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
                            image: NetworkImage(viewsList[index]["imageProfile"]),
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
                                "${viewsList[index]["name"]} ⦿ ${viewsList[index]["age"]}",
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
                                      "${viewsList[index]["city"]} ${viewsList[index]["country"]}",
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
