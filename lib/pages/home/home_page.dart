import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages=[
    MainFoodPage(),
    Container(child: Center(child: Text("next page")),),
    Container(child: Center(child: Text("next next page")),),
    Container(child: Center(child: Text("next next next page")),),
  ];
  void onTaoNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTaoNav,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
          label: Text("home").toString(),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.archive),
          label: Text("history").toString(),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
          label: Text("cart").toString(),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person),
          label: Text("me").toString(),
        ),
      ],),
    );
  }
}
