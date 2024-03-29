
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';

class FavoriteSentFavoriteReceivedScreen extends StatefulWidget {
  const FavoriteSentFavoriteReceivedScreen({super.key});

  @override
  State<FavoriteSentFavoriteReceivedScreen> createState() => _FavoriteSentFavoriteReceivedScreenState();
}

class _FavoriteSentFavoriteReceivedScreenState extends State<FavoriteSentFavoriteReceivedScreen> {

  bool isFavoriteSentClicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List favoritesList = [];

  getFavoriteKeysList() async {

    if(isFavoriteSentClicked){

      var favoriteSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("favoriteSent")
          .get();

      for(int i=0; i<favoriteSentDocument.docs.length; i++){
        favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }

      getKeysDataFromUsersCollection(favoriteSentList);

    }
    else{

      var favoriteReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("favoriteReceived")
          .get();

      for(int i=0; i<favoriteReceivedDocument.docs.length; i++){
        favoriteReceivedList.add(favoriteReceivedDocument.docs[i].id);
      }

      getKeysDataFromUsersCollection(favoriteReceivedList);
    }
  }

  getKeysDataFromUsersCollection(List<String> keysList) async {

    var allUsersDocument = await FirebaseFirestore.instance.collection("users").get();

    for(int i=0; i<allUsersDocument.docs.length; i++){
      for(int j=0; j<keysList.length; j++){

        if((allUsersDocument.docs[i].data() as dynamic)["uid"] == keysList[j]){
          favoritesList.add(allUsersDocument.docs[i].data());
        }

      }
    }

    setState(() {
      favoritesList;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFavoriteKeysList();
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

                favoriteSentList.clear();
                favoriteSentList = [];
                favoriteReceivedList.clear();
                favoriteReceivedList = [];
                favoritesList.clear();
                favoritesList = [];

                setState(() {
                  isFavoriteSentClicked = true;
                });

                getFavoriteKeysList();
              },
              child: Text(
                "My Favorites",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isFavoriteSentClicked ? FontWeight.bold : FontWeight.normal,
                  color: isFavoriteSentClicked ? Colors.white : Colors.grey,
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

                favoriteSentList.clear();
                favoriteSentList = [];
                favoriteReceivedList.clear();
                favoriteReceivedList = [];
                favoritesList.clear();
                favoritesList = [];

                setState(() {
                  isFavoriteSentClicked = false;
                });

                getFavoriteKeysList();

              },
              child: Text(
                "I'm Their Favorite",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isFavoriteSentClicked ? FontWeight.normal : FontWeight.bold,
                  color: isFavoriteSentClicked ? Colors.grey : Colors.white,
                ),
              ),
            ),

          ],
        ),
      ),

      body: favoritesList.isEmpty
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
            children: List.generate(favoritesList.length, (index){
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
                            image: NetworkImage(favoritesList[index]["imageProfile"]),
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
                                  "${favoritesList[index]["name"]} ⦿ ${favoritesList[index]["age"]}",
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
                                        "${favoritesList[index]["city"]} ${favoritesList[index]["country"]}",
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
