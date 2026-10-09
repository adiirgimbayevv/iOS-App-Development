

import 'package:flutter/material.dart';

void main() {
  runApp(const BusinessApp()); 
}

class BusinessApp extends StatelessWidget {
  const BusinessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: ProfileCardScreen(), );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() =>_ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
 
  bool _isFollowing =false;
  int _followerCount =69;
  int _likesCount=67;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 178, 59, 225), 
      appBar: AppBar(
        title: const Text('Regular Dude Profile'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: const Color.fromARGB(255, 114, 111, 111),
        centerTitle: true,
      ),

      body: Center(
        child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(24.0), 
          child: Column(
            children: [
              CircleAvatar(radius: 40,backgroundColor: const Color.fromARGB(255, 159, 32, 197),child: Icon(Icons.person, size: 50, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 16),
              Text('Adi Irgimbayev'),
              Text('Regular Dude'),
              SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                  children: [
                    Text('$_followerCount', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      const Text('Followers', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 12),
                SizedBox(
                  width: 130,
                  child: ElevatedButton.icon(
                  onPressed: _toggleFollow,
                  icon: Icon(_isFollowing?Icons.check:Icons.person_add),
                  label: Text(_isFollowing ?'Following' :'Follow',maxLines: 1,overflow: TextOverflow.ellipsis,),),
                              ),
                         const SizedBox(height: 8),
                          TextButton(onPressed: _resetFollowers, child: Text('Reset', style: TextStyle(color: Colors.grey, fontSize: 12)),),
                          ],),

                   Column(
                    children: [
                     Text('$_likesCount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       const Text('Likes❤️', style: TextStyle(color: Colors.grey)),
                       const SizedBox(height: 12),

                   Row(
                     children: [
                     OutlinedButton.icon(onPressed: _incrementLike, icon:const Icon(Icons.favorite), label: const Text('Like'),),
                      const SizedBox(width:8),
                    OutlinedButton.icon(onPressed: _decrementLike, icon: const Icon(Icons.favorite_border), label: const Text('Unlike'),),
                    ],
                  ),
                    const SizedBox(height: 8),
                    TextButton(onPressed: _resetLikes, child: const Text('Reset', style: TextStyle(color: Colors.grey, fontSize:12 )),),
            ],
          ),],
        ), 
      ],),),
    ),
   ),
  );
  }



  void _toggleFollow() {
    setState(() {
      _isFollowing =!_isFollowing;
      if (_isFollowing) {
        _followerCount++;
      } else {
        _followerCount--;}
    });
  }

  void _incrementLike() {
    setState((){
      _likesCount++;
    });
  }

  void _decrementLike() {
    setState((){
      _likesCount--;
    });}

  void _resetFollowers() {
    setState(() {
      _isFollowing =false;
      _followerCount =0;
    });
  }

  void _resetLikes() {
    setState(() {
      _likesCount=0;
    });}
}
