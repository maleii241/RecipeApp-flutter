import 'package:flutter/material.dart';

import 'package:flutter_smart_home_ui/shared.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'constants.dart';
import 'data.dart';
import 'detail.dart';

class Home extends KFDrawerContent {
  Home({
    Key key,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<bool> optionSelected = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onPressed: widget.onMenuPressed,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('images/IMG_20210524_133958.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(width: 15)
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(

                  children: [

                    buildTextTitleVariation1('RecipeApp dev.'),

                    buildTextSubTitleVariation1('Рецепты здоровой и питательной пищи'),

                    SizedBox(
                      height: 32,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        option('Овощной', 'assets/icons/salad.png', 0),
                        SizedBox(
                          width: 8,
                        ),
                        option('Рис', 'assets/icons/rice.png', 1),
                        SizedBox(
                          width: 8,
                        ),
                        option('Фрукты', 'assets/icons/fruit.png', 2),

                      ],
                    ),

                  ],
                ),
              ),

              SizedBox(
                height: 24,
              ),

              Container(
                height: 350,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: buildRecipes(),
                ),
              ),

              SizedBox(
                height: 16,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [

                    buildTextTitleVariation2('Популярная', false),

                    SizedBox(
                      width: 8,
                    ),

                    buildTextTitleVariation2('Еда', true),

                  ],
                ),
              ),

              Container(
                height: 190,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  children: buildPopulars(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> buildPopulars(){
    List<Widget> list = [];
    for (var i = 0; i < getRecipes().length; i++) {
      list.add(buildPopular(getRecipes()[i]));
    }
    return list;
  }


  Widget buildPopular(Recipe recipe){
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [

          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(recipe.image),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  buildRecipeTitle(recipe.title),

                  buildRecipeSubTitle(recipe.description),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildCalories(recipe.calories.toString() + " Kcal"),

                      Icon(
                        Icons.favorite_border,
                      )

                    ],
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );}


  Widget option(String text, String image, int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          optionSelected[index] = !optionSelected[index];
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: optionSelected[index] ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [

            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(
                image,
                color: optionSelected[index] ? Colors.white : Colors.black,
              ),
            ),

            SizedBox(
              width: 8,
            ),

            Text(
              text,
              style: TextStyle(
                color: optionSelected[index] ? Colors.white : Colors.black,
                fontSize: 14,
               // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


    List<Widget> buildRecipes(){
      List<Widget> list = [];
      for (var i = 0; i < getRecipes().length; i++) {
        list.add(buildRecipe(getRecipes()[i], i));
      }
      return list;
    }

  Widget buildRecipe(Recipe recipe, int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(recipe: recipe)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
        padding: EdgeInsets.all(16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(
              child: Hero(
                tag: recipe.image,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(recipe.image),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),

            buildRecipeTitle(recipe.title),

            buildTextSubTitleVariation2(recipe.description),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                buildCalories(recipe.calories.toString() + " Kcal"),

                Icon(
                  Icons.favorite_border,
                )

              ],
            ),

          ],
        ),
      ),
    );
  }






  Widget listItemStats(String imgpath, String name, bool value){
    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: value == true ? Colors.white : Color.fromRGBO(75, 97, 88, 1.0)
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Image(image: AssetImage(imgpath),width: 45,height: 45, color: value == true ? Colors.black : Colors.white),
          SizedBox(height: 15),
          Text(name, style: TextStyle(fontSize: 13, color: value == true ? Colors.black : Colors.white)),
          SizedBox(height: 5),
          Switch(
            value: value,
            onChanged: (newVal){
              setState(() {
                value = newVal;
                print(newVal);
              });
            },
            activeColor: Colors.green,
          )
        ],
      ),
    );
  }
}
