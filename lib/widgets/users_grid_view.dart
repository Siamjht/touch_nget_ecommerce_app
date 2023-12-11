
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants/urls.dart';
import '../models/users.dart';


class UserGridView extends StatelessWidget {
  const UserGridView({super.key, required this.users});

  final Users users;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: (MediaQuery.of(context).size.width) / 2,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: CachedNetworkImage(
                imageUrl:
                "${Urls.apiServerBaseUrl}${users.userImage}",
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator())),
          ),
        ),
        Text(
          users.userName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
