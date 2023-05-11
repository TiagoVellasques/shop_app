import 'package:flutter/material.dart';
import 'package:shop_app/models/category/category_model.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                categories.length, (index) => CategoryCard(categories[index])),
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(          
          radius: 30,
          backgroundColor: category.color,          
          child: SizedBox(
            width:28,
            child: Image.asset(category.catIcon, fit: BoxFit.cover),
          ),
        ),
        Text(category.catName),
      ],
    );
  }
}