import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/OpenHabState.dart';

import 'RoomsDetailsPage.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OpenHabState>(
      builder: (context, opanhabState, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: opanhabState.rooms.length,
              itemBuilder: ((context, index) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: ((context) => RoomsDetailsPage(title: opanhabState.rooms.elementAt(index),)))),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(imageUrl: 'https://www.cpomagazine.com/wp-content/uploads/2019/10/smart-devices-leaking-data-to-tech-giants-raises-new-iot-privacy-issues_1500-1024x587.jpg')),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.8)]
                              )
                          ),
                        ),
                        Column(
                          children: [
                            const Spacer(flex: 3,),
                            Row(
                              children: [
                                const SizedBox(width: 20,),
                                Text(opanhabState.rooms.elementAt(index), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                              ],
                            ),
                            const Spacer(flex: 1,),
                          ],
                        )
                      ]
                    ),
                ))
            )),
          ),
        )
      ),
    );
  }
}