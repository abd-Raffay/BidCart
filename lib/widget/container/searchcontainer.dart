
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key, required this.text, this.icon,  this.showBackground= true,this.showBorder=true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.0),
        border:showBorder? Border.all(color: Colors.grey):null,
      ),
      child:  Row(
        children: [
          const Icon(Icons.search,color: Colors.black,),
          const SizedBox(width: 16.0,),
          Text(text ,style: const TextStyle(
              color: Colors.grey
          ),),
        ],
      ),

    );
  }
}
