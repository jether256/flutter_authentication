import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/firebase_service.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {



  final FirebaseAuthService _auth=FirebaseAuthService();

  final _formKey=GlobalKey<FormState>();

  final _name=TextEditingController();
  final _num=TextEditingController();
  final _ema=TextEditingController();
  final _pass=TextEditingController();
  final _address=TextEditingController();
  final _lon=TextEditingController();
  final _lat=TextEditingController();



  bool verifyButton=false;

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor:Colors.white,
      body: SafeArea(
          child:Form(
            key: _formKey,
            child: ListView(
              padding:const EdgeInsets.only(left: 10,right: 10),
              children:  [
                const Padding(
                  padding: EdgeInsets.only(top: 30.0,bottom: 30),
                  child: Center(child: Text('REGISTER',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                ),

                //first name
                TextFormField(
                    controller: _name,
                    cursorColor: Colors.blue.shade200,
                    decoration: InputDecoration(
                        hintText: 'Name',
                        prefixIcon:const Icon(Icons.person,size: 18,color:Colors.grey,),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.blue),
                        )
                    ),

                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Name';

                      }
                      return null;
                    }

                ),


                const SizedBox(height: 10,),


                //email
                TextFormField(
                    controller: _ema,
                    cursorColor: Colors.blue.shade200,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email,size: 18,color:Colors.grey,),
                        filled: true,
                        fillColor:Colors.grey.shade200,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.blue),
                        )
                    ),
                    validator: (value){
                      if(value!.isEmpty){

                        return 'Enter Email';
                      }
                      bool _isValid= (EmailValidator.validate(value));
                      if(_isValid==false){
                        return 'Enter Valid Email Address';

                      }
                      return null;

                    }
                ),

                const SizedBox(height: 10,),

                //password
                TextFormField(
                    controller: _pass,
                    cursorColor: Colors.blue.shade200,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon:const Icon(Icons.lock,size: 18,color:Colors.grey,),
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: _secureText
                              ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                            size: 20,
                          )
                              : const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        filled: true,
                        fillColor:Colors.grey.shade200,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.blue),
                        )
                    ),

                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Password';

                      }
                      return null;
                    }

                ),

                const SizedBox(height: 10,),

                //sign up
            Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: (){



              if(_formKey.currentState!.validate()){

                if (_name.text !='' ||
                    _ema.text !=''||
                    _pass.text !=''
                            ) {


                  _auth.register(
                       _name.text,
                       _ema.text,
                       _pass.text,
                       context);



                  //set text fields to empty after
                  _name.text =='' ;
                  _ema.text =='';
                  _pass.text =='';

                }
              }

            }, child:const Text('Sign Up',style: TextStyle(color: Colors.white),),
          ),
        ),

                const SizedBox(height: 10,),


                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: (){

                      //Navigator.pushNamed(context, LoginScreen.id);

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));

                    }, child:const Text('Already have account? Login',style: TextStyle(color: Colors.white),),
                  ),
                ),
                //


                const SizedBox(height: 50,),
              ],
            ),
          )
      ),
    );
  }
}
