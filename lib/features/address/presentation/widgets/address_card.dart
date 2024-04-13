import 'package:flutter/material.dart';

import '../../domain/entities/address.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(address.textual),
      subtitle: Text(address.location.toString()),
    );
  }
}
