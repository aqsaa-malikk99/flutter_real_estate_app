import 'package:flutter/material.dart';
import 'package:real_estate_app/core/constants/colors.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with TickerProviderStateMixin {
  late List<String> messages;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    // Dummy messages
    messages =
        List<String>.generate(15, (index) => "Random Message ${index + 1}");

    // Create a list of animation controllers and animations for each message
    _controllers = List<AnimationController>.generate(
      messages.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(parent: controller, curve: Curves.easeIn);
    }).toList();

    // Start each animation with a delay to create a staggered effect
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColorTransparent,
      appBar: AppBar(
        backgroundColor: kBlackColorTransparent,
        elevation: 0.7,
        foregroundColor: kPrimaryColor,
        title: Text("Messages"),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: _animations[index],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                onTap: (){

                },
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kGrey,
                    ),
                    child: Icon(
                      Icons.person,
                      color: kWhiteColor,
                      size: 24,
                    ),
                  ),
                ),
                trailing:
                Text(
                  '27 Jan',
                  style: TextStyle(color: kGrey),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messages[index],
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'This is a test message',
                      style: TextStyle(color: kGrey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
