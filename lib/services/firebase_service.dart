
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';


class FirebaseAuthService{

final FirebaseAuth _auth = FirebaseAuth.instance;



register(String name,String email,String password,context,) async {

  try{
    UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Registered Successfully",style: TextStyle(fontSize: 18),),
    ));


    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));

    return credential.user;

  }on FirebaseAuthException catch(e){

    if(e.code=='weak-password'){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Password is too weak",style: TextStyle(fontSize: 18),),
      ));
    }

    else if(e.code=='email-already-in-use'){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Account already exists",style: TextStyle(fontSize: 18),),
      ));
    }


  }

  catch(e){

    print("some error occured");
  }


  return null;
}



login(String email,String password,context) async{

  try{
    UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Logged In Successfully",style: TextStyle(fontSize: 18),),
    ));


    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));

    return credential.user;

  }on FirebaseAuthException catch(e){

    if(e.code=='user-not-found'){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("No user found for that email",style: TextStyle(fontSize: 18),),
      ));
    }

    else if(e.code=='wrong-password'){

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Wrong password",style: TextStyle(fontSize: 18),),
      ));
    }


  }

  catch(e){

    print("some error occured");
  }


  return null;
}


}