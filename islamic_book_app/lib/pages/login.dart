import 'package:flutter/material.dart';
import 'NavDrawer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Center(child: Text('বাংলা হাদিস')),
        actions: [
          PopupMenuButton(
            color: Colors.black,
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(
                child: Text(
                  "Night Mode",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
              PopupMenuItem(
                  child: Text(
                "Night Mode On",
                style: TextStyle(color: Colors.greenAccent),
              )),
              PopupMenuItem(
                child: Text(
                  "Rate Us ",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.greenAccent,
      ),

      body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Welcome বাংলা হাদিস App',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                  
                      
                      child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent, // background (button) color
                               onPrimary: Colors.white, // foreground (text) color
                                           ),
                        
                        child: Text('Login'),
                        onPressed: () {
                          print(nameController.text);
                          print(passwordController.text);
                          
                        },
                      )
                      ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Does not have account?'),
                      ),
                      
                        
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                            'Forgot Password?',
                            style: TextStyle(fontSize: 20),
                        ),
                         ),
                       
                      
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )
            ),
             bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedLabelStyle: TextStyle(color: Colors.greenAccent),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            tooltip: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favourite',
            tooltip: 'Favourite',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Account', tooltip: "Account"),
        ],
      ),
    );
  }
}