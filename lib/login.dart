import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/register.dart';
import 'package:flutter_firebase/services/firebase_service.dart';

class Login extends StatefulWidget {


  static const  String id='login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {




  final FirebaseAuthService _auth=FirebaseAuthService();

  final _formKey=GlobalKey<FormState>();
  final _ema=TextEditingController();
  final _pass=TextEditingController();



  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor:Colors.white,
      body: SafeArea(

          child:Form(
            key: _formKey,
            child: ListView(
              padding:const EdgeInsets.only(left: 10,right: 10),
              children:  [
                const Padding(
                  padding: EdgeInsets.only(top: 30.0,bottom: 30),
                  child: Center(child: Text('LOGIN',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                ),




                //email textfield
                TextFormField(
                    controller: _ema,
                    cursorColor: Colors.blue.shade200,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon:const Icon(Icons.email,size: 18,color:Colors.grey,),
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


                //password textfiled
                TextFormField(
                    controller: _pass,
                    cursorColor: Colors.blue.shade200,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock,size: 18,color:Colors.grey,),
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

                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){

                        //Navigator.pushReplacementNamed(context,CheckMail.id);

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> const CheckMail()));


                        //EasyLoading.showSuccess('Forgot password clicked.....');

                      },
                      child:  const Text('Forgot password?',style: TextStyle(color: Colors.blue),
                      ),
                    )),

                const SizedBox(height: 20,),

            Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: (){


              if(_formKey.currentState!.validate()){

                //continue if the textfields are not empty
                if (
                _ema.text !=''||
                    _pass.text !=''
                ) {


                  _auth.login(
                      _ema.text,
                      _pass.text,
                      context);



                  //set text fields to empty after
                  _ema.text =='';
                  _pass.text =='';


                }


              }

            }, child:const Text('Login',style: TextStyle(color: Colors.white),),
          ),
        ),

                const SizedBox(height: 20,),

                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: (){

                        //EasyLoading.showSuccess('Sign Up Clicked...');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register()));

                      },
                      child:   const Text('Dont have an account? ${'Sign Up'}',style: TextStyle(color: Colors.blue),
                      ),
                    )),

                const SizedBox(height: 50,),
              ],
            ),
          )
      ),
    );
  }
}
