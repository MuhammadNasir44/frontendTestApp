import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:testfrontendapp/profile_provider.dart';
import 'package:testfrontendapp/view_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: Consumer<ProfileProvider>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Text("Profile Screen"),
          ),
          body: ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              color: Color(0xff342FD5),
            ),
            inAsyncCall: model.state == ViewState.busy,
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    child: ClipOval(
                      child: Image.network(
                        "https://i.pinimg.com/550x/38/09/c3/3809c319d6b40a4efda99bf5500fe6ef.jpg",
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    "Jessica",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua"),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Posts",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: model.postsList.length == 0
                        ? Text("loading posts...")
                        : ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            primary: true,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.pink)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.postsList[index].title ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(model.postsList[index].body ?? ''),
                                    InkWell(
                                      onTap: () {
                                        model.onLikeButtonTap(index);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              '${model.postsList[index].likeCount} Likes'),
                                          SizedBox(width: 8),
                                          Icon(Icons.thumb_up),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );

                              // ListTile(
                              //   title: model.postsList[index].title == null
                              //       ? Text("loading..")
                              //       : Text(model.postsList[index].title ?? ''),
                              //   subtitle: model.postsList[index].body == null
                              //       ? Text("loading..")
                              //       : Text(model.postsList[index].body ?? ''),
                              // );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
