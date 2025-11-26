import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? ontap;
  final String name;
  const MyButton({super.key, required this.name, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.tertiary),
        // width: MediaQuery.of(context).size.width,
        // height: 50,
           child: Padding(
             padding: const EdgeInsets.all(16),
             child: Center(child: 
             Text(name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
           ),
      ),
    );
  }
}