import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  MqttServerClient client;
  final String serverUri = "mqtt://your_broker_ip:1883";
  final String clientId = "your_client_id";
  final String topic = "your_topic";

  MqttService() {
    client = MqttServerClient(serverUri, clientId);
    client.logging(on: true);

    client.onDisconnected = () {
      print('Disconnected');
    };

    final MqttConnectMessage connectMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .keepAliveFor(60)
        .withWillQos(MqttQos.atLeastOnce)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .withWillRetain()
        .authenticateAs('your_username', 'your_password');

    client.connectionMessage = connectMessage;

    client.connect().then((value) {
      if (value == MqttConnectReturnCode.connectionAccepted) {
        print('Connected');
        client.subscribe(topic, MqttQos.atLeastOnce);

        client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final MqttPublishMessage recMess = c[0].payload;
          final String payload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

          print('Received message:$payload from topic:${c[0].topic}');
        });
      } else {
        print('Connection failed - disconnecting');
        client.disconnect();
      }
    });
  }

  void dispose() {
    client.disconnect();
  }
}
