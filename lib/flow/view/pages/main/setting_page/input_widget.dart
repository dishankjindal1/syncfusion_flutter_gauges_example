import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    required this.label,
    this.isMandatory = false,
    this.value,
    this.callback,
    this.validator,
    this.type,
    super.key,
  });

  final bool isMandatory;
  final String label;
  final String? value;
  final ValueChanged<String?>? callback;
  final String? Function(String?)? validator;
  final TextInputType? type;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController textEditingController = TextEditingController();
  bool isSomethingNew = false;

  @override
  void initState() {
    super.initState();

    textEditingController.text = widget.value ?? textEditingController.text;

    textEditingController.addListener(() {
      if (mounted) {
        setState(() {
          isSomethingNew = textEditingController.text != widget.value;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant final InputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (mounted) {
        setState(() {
          textEditingController.text =
              widget.value ?? textEditingController.text;
          isSomethingNew = textEditingController.text != widget.value;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: TextFormField(
          keyboardType: widget.type,
          readOnly: widget.callback == null,
          controller: textEditingController,
          inputFormatters: [
            if (widget.type == TextInputType.phone)
              LengthLimitingTextInputFormatter(10),
          ],
          decoration: InputDecoration(
            suffixIcon: isSomethingNew
                ? IconButton(
                    onPressed: () {
                      widget.callback?.call(textEditingController.text);
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  )
                : null,
            label: Text.rich(
              TextSpan(
                text: widget.label,
                children: [
                  if (widget.isMandatory)
                    const TextSpan(
                      text: ' *',
                      //   style: MyStyles.text.lato16_400P.negative,
                    ),
                ],
              ),
              //   style: MyStyles.text.lato16_400P.primary,
            ),
            hintText: 'Enter your ${widget.label.toLowerCase()}',
            // hintStyle: MyStyles.text.lato12_400P.secondary,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                // color: MyStyles.color.primary,
                width: 2,
              ),
            ),
          ),
          //   style: MyStyles.text.lato16_600P.primary,
          onSaved: widget.callback,
          validator: widget.validator,
        ),
      );
}
