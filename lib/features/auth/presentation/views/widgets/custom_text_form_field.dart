import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required TextEditingController controller,
    this.onChange,
    this.focusNode,
    this.validator,
    this.label,
    this.maxLine = 1,
    required String hintText,
    this.icon,
  }) : _controller = controller,
       _hintText = hintText;

  final TextEditingController _controller;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  final String? label;
  final int maxLine;
  final FocusNode? focusNode;
  final String _hintText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          )
        else
          const SizedBox.shrink(),
        const SizedBox(height: 10),
        TextFormField(
          validator: validator,
          maxLines: maxLine,
          focusNode: focusNode,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
            ),
            hintText: _hintText,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: icon,
          ),
          onChanged: onChange,
        ),
      ],
    );
  }
}
