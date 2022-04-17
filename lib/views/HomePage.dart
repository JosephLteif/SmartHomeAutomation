import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/providers/ThingsState.dart';
import 'package:smarthomeautomation/services/OpenHabService.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/widgets/CardElement.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    MqttServerClient client =
      MqttServerClient.withPort('192.168.1.24', 'flutter_client', 1883);
    String _temp = '0.0';

  @override
  void initState() {
    // TODO: implement initState
    // connect();
  }
  @override
  Widget build(BuildContext context) {
    print(Provider.of<ThingsState>(context).things);
    return Consumer<AppearanceState>(
      builder: ((context, appearanceState, child) => Consumer<ThingsState>(
        builder: (context, thingsState, child) => Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Smart ",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: appearanceState.isDarkMode
                                          ? darkColorTheme
                                          : lightColorTheme)),
                              const Text("Home",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Provider.of<AppearanceState>(context,
                                        listen: false)
                                    .toggleDarkMode();
                              },
                              icon: Icon(Provider.of<AppearanceState>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? Icons.dark_mode
                                  : Icons.light_mode)),
                          CircleAvatar(
                            backgroundColor: appearanceState.isDarkMode
                                ? darkColorTheme
                                : lightColorTheme,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("My ",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold)),
                              Text("Home",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: appearanceState.isDarkMode
                                          ? darkColorTheme
                                          : lightColorTheme)),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            color: appearanceState.isDarkMode
                                ? darkColorTheme
                                : lightColorTheme,
                            onPressed: () {},
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                        children: [
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.3,
                            child: CardElement(
                              device: "Thermometer",
                              value: "24",
                              unit: "°C",
                              title: "Living Room",
                              icon: Icons.home,
                              color: const Color(0xFF6f5eff),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.5,
                            child: CardElement(
                              device: "Thermometer",
                              value: "24",
                              unit: "°C",
                              title: "Living Room",
                              icon: Icons.home,
                              color: const Color(0xFF14c3b5),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.5,
                            child: CardElement(
                              device: "Thermometer",
                              value: "24",
                              unit: "°C",
                              title: "Living Room",
                              icon: Icons.home,
                              color: const Color(0xFFf26889),
                            ),
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.3,
                            child: CardElement(
                              device: "Thermometer",
                              value: "24",
                              unit: "°C",
                              title: "Living Room",
                              icon: Icons.home,
                              color: const Color(0xFFe27061),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
      )),
    );
  }

// Future<MqttServerClient> connect() async {
//   client.logging(on: true);
//   client.onConnected = onConnected;
//   client.onDisconnected = onDisconnected;
//   client.onSubscribed = onSubscribed;
//   client.onSubscribeFail = onSubscribeFail;
//   client.pongCallback = pong;

//   final connMessage = MqttConnectMessage()
//   .withClientIdentifier("client-1");
//   client.connectionMessage = connMessage;
//   try {
//     await client.connect();
//   } catch (e) {
//     print('Exception: $e');
//     client.disconnect();
//   }

//   client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {   
//     MqttPublishMessage temp = c[0].payload as MqttPublishMessage;
//     _temp = MqttPublishPayload.bytesToStringAsString(temp.payload.message);
//     setState(() {
      
//     });
//     print('Received message:${_temp} from topic: ${c[0].topic}>');
//   });

//   return client;
// }

// void subscribeToTopic(MqttServerClient client) {
//   client.subscribe('real_unique_topic', MqttQos.exactlyOnce);
// }

// // connection succeeded
// void onConnected() {
//   print('Connected');
// }

// // unconnected
// void onDisconnected() {
//   print('Disconnected');
// }

// // subscribe to topic succeeded
// void onSubscribed(String topic) {
//   print('Subscribed topic: $topic');
// }

// // subscribe to topic failed
// void onSubscribeFail(String topic) {
//   print('Failed to subscribe $topic');
// }

// // unsubscribe succeeded
// void onUnsubscribed(String topic) {
//   print('Unsubscribed topic: $topic');
// }

// // PING response received
// void pong() {
//   print('Ping response client callback invoked');
// }

// void publishMessage(){
//   const pubTopic = 'test';
//   final builder = MqttClientPayloadBuilder();
//   builder.addString('Hello MQTT');
//   client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
// }


}
