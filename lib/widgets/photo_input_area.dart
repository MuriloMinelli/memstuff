import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoInputArea extends StatefulWidget {
  final double height;
  final double radius;
  final IconData icon;
  final Function(String) onChanged;
  final String initialValue;

  const PhotoInputArea({
    Key key,
    this.height = 200.0,
    this.radius = 20.0,
    this.initialValue,
    this.icon = Icons.add_a_photo_outlined,
    this.onChanged,
  }) : super(key: key);

  @override
  _PhotoInputAreaState createState() => _PhotoInputAreaState();
}

class _PhotoInputAreaState extends State<PhotoInputArea> {
  final _picker = ImagePicker();
  File _image;

  @override
  void initState() {
    if (widget.initialValue != null && widget.initialValue.isNotEmpty) {
      _image = File(widget.initialValue);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onCapturePhoto,
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple[200]),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: Center(
          child: _image == null
              ? Icon(
                  widget.icon,
                  size: widget.height * 0.5,
                  color: Colors.deepPurple[200],
                )
              : Image.file(_image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Future _onCapturePhoto() async {
    final file = await _picker.getImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        _image = File(file.path);
      });
      widget.onChanged(file.path);
    }
  }
}
