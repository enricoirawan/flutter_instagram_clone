import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/edit_profile/edit_profile_screen.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({Key key, this.isCurrentUser, this.isFollowing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? FlatButton(
            onPressed: () => Navigator.of(context).pushNamed(
              EditProfileScreen.routeName,
              arguments: EditProfileScreenArgs(context),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16.0),
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          )
        : FlatButton(
            onPressed: () {},
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: TextStyle(fontSize: 16.0),
            ),
            color:
                isFollowing ? Colors.grey[300] : Theme.of(context).primaryColor,
            textColor: isFollowing ? Colors.black : Colors.white,
          );
  }
}
