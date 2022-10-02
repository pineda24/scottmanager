import 'package:flutter/material.dart';
import '../style/style.dart';

class Button extends StatefulWidget {
  final String text;
  final Function() onPressed;
  final TextStyle textStyle;
  final bool enabled;

  const Button(
      {Key? key,
      this.text = '',
      required this.onPressed,
      this.textStyle = Style.blackMediumText,
      this.enabled = true})
      : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        height: 24,
        child: Center(
          child: Text(
            widget.text ?? '',
            style: Style.whiteNormalText,
          ),
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
        backgroundColor:
            MaterialStateProperty.all<Color>(Style.primaryColorBold),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        )),
      ),
      onPressed: widget.enabled
          ? () async {
              try {
                setState(() => _processing = true);
                await widget.onPressed();
              } catch (e) {
                print(e);
              } finally {
                setState(() => _processing = false);
              }
            }
          : null,
    );
  }
}
