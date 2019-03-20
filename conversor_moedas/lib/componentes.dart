import 'package:flutter/material.dart';

class componentes {
  Widget LabelCentral(String descricao) {
    return Center(
      child: Text(
        descricao,
        style: TextStyle(color: Colors.white, fontSize: 25.00),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget BuiderTextField(String label, String prefix,
      TextEditingController controller, Function onChanged) {
    return TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: Colors.amber, fontSize: 25.0),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber),
          border: OutlineInputBorder(),
          prefixText: prefix,
        ));
  }
}
