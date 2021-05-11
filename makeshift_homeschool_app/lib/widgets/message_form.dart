import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  MessageForm({Key key}) : super(key: key);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _controller = TextEditingController();
  String _message;

  void _onPressed() {
    print(_message);
    _controller.clear();
    _message = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Type a Message",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(10),
                ),
                minLines: 1,
                maxLines: 70,
                onChanged: (value) {
                  setState(() {
                    _message = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 5,
            ),
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              fillColor: _message == null || _message.isEmpty
                  ? Colors.blueGrey
                  : Colors.blue,
              onPressed:
                  _message == null || _message.isEmpty ? null : _onPressed,
              child: Text(
                "SEND",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
