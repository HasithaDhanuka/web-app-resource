import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/Utils/view_wrapper.dart';
import 'package:web_app/model/food.dart';
import 'package:web_app/screen/foodItem_frame_view.dart';
import 'package:web_app/widgets/rounded_border.dart';
import '../firebase/firebase_food.dart';

class FoodItemsView extends StatefulWidget {
  const FoodItemsView({super.key});

  @override
  State<FoodItemsView> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItemsView> {
  // late Future<List<ProductItems>> productItem;
  ////   For WEB
  // static Future<List<ProductItems>> getProduct() async {
  //   const url =
  //       "https://github.com/HasithaDhanuka/matsuyama_web/blob/main/assets/jsonfile/item.json";
  //   //"https://drive.google.com/uc?export=view&id=1cVyziSI0oSriADOiS7ZoOcNeZQQwKx-h";
  //   final response = await http.get(Uri.parse(url));
  //   final body = json.decode(response.body);
  //   print("network is loading");
  //   print(body);
  //   return body.map<ProductItems>(ProductItems.fromJson).toList();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   //  productItem = getItems(context);
  // }

  // static Future<List<ProductItems>> getItems(BuildContext context) async {
  //   final data =
  //       await DefaultAssetBundle.of(context).loadString("jsonfile/item.json");
  //   final body = json.decode(data);
  //   return body.map<ProductItems>(ProductItems.fromJson).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return ViewWrapper(
        desktopView: desktopView(
            crossAxisItemsCount: 5, scrollDirectionAxis: Axis.vertical),
        mobileView: mobileView(
            crossAxisItemsCount: 2, scrollDirectionAxis: Axis.horizontal));
  }

// ***************************************************************//
// ####################   DESKTOP VIEW    ##########################//

  Widget desktopView(
      {required int crossAxisItemsCount, required Axis scrollDirectionAxis}) {
    //final int cross_axis_items;
    return SingleChildScrollView(
      scrollDirection: scrollDirectionAxis,
      physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            roundedBorder(
              title: "Other Items",
              height: 400,
              widget: bodyOfDevicer(
                viewportFraction: 0.3,
                sliderView: true,
                sliderViewAutoPlay: true,
                sliderViewItemHeight: 370,
                sliderViewAutoPlayDuration: 3,
                crossAxisItemsCount: crossAxisItemsCount,
                scrollDirectionAxis: scrollDirectionAxis,
                readfoodItems: ReadOtherItems(),
              ),
            ),
            roundedBorder(
              title: "Grains Items",
              height: 400,
              widget: bodyOfDevicer(
                viewportFraction: 0.3,
                sliderView: false,
                sliderViewAutoPlay: true,
                sliderViewItemHeight: 370,
                sliderViewAutoPlayDuration: 3,
                crossAxisItemsCount: crossAxisItemsCount,
                scrollDirectionAxis: scrollDirectionAxis,
                readfoodItems: ReadGrainsItems(),
              ),
            ),
            roundedBorder(
              title: "Powder Items",
              height: 400,
              widget: bodyOfDevicer(
                viewportFraction: 0.3,
                sliderView: true,
                sliderViewAutoPlay: true,
                sliderViewItemHeight: 370,
                sliderViewAutoPlayDuration: 4,
                crossAxisItemsCount: crossAxisItemsCount,
                scrollDirectionAxis: scrollDirectionAxis,
                readfoodItems: ReadPowderItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }
// ***************************************************************//
// ####################   Mobile VIEW    ##########################//

  Widget mobileView(
      {required int crossAxisItemsCount, required Axis scrollDirectionAxis}) {
    return Column(
      children: [
        roundedBorder(
          title: "Other Items",
          height: 450,
          widget: bodyOfDevicer(
            sliderView: true,
            sliderViewAutoPlay: true,
            sliderViewItemHeight: 370,
            viewportFraction: 0.8,
            sliderViewAutoPlayDuration: 3,
            crossAxisItemsCount: crossAxisItemsCount,
            scrollDirectionAxis: scrollDirectionAxis,
            readfoodItems: ReadOtherItems(),
          ),
        ),
        roundedBorder(
          title: "Grains Items",
          height: 400,
          widget: bodyOfDevicer(
            sliderView: false,
            viewportFraction: 0.8,
            sliderViewAutoPlay: true,
            sliderViewItemHeight: 370,
            sliderViewAutoPlayDuration: 3,
            crossAxisItemsCount: crossAxisItemsCount,
            scrollDirectionAxis: scrollDirectionAxis,
            readfoodItems: ReadGrainsItems(),
          ),
        ),
        roundedBorder(
          title: "Powder Items",
          height: 350,
          widget: bodyOfDevicer(
            viewportFraction: 0.8,
            sliderView: true,
            sliderViewAutoPlay: true,
            sliderViewItemHeight: 300,
            sliderViewAutoPlayDuration: 4,
            crossAxisItemsCount: crossAxisItemsCount,
            scrollDirectionAxis: scrollDirectionAxis,
            readfoodItems: ReadPowderItems(),
          ),
        ),
      ],
    );
  }

// ***************************************************************//
// ####################   Steram Data    ##########################//
  Widget bodyOfDevicer({
    required bool sliderView,
    required bool sliderViewAutoPlay,
    required int sliderViewAutoPlayDuration,
    required int crossAxisItemsCount,
    required double viewportFraction,
    required double sliderViewItemHeight,
    required Axis scrollDirectionAxis,
    required Stream<List<FoodItem>> readfoodItems,
  }) {
    return StreamBuilder<List<FoodItem>>(
      stream: readfoodItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        }

        if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: TextStyle(color: MyColor.myRed),
          ));
        } else if (snapshot.hasData) {
          final productItems = snapshot.data!;

          return sliderView
              ? itemsSliderView(
                  itemLength: productItems,
                  autoPlay: true,
                  timeDuration: sliderViewAutoPlayDuration,
                  itemHeight: sliderViewItemHeight,
                  viewportFraction: viewportFraction)
              : gridItemViewr(
                  crossAxisItemsCount: crossAxisItemsCount,
                  scrollDirectionAxis: scrollDirectionAxis,
                  itemLength: productItems);
        } else {
          return Text(
            "Item Not Founded",
            style: TextStyle(color: MyColor.myOrange),
          );
        }
      },
    );
  }
}
// ***************************************************************//
// ####################   Grid VIEW    ##########################//

Widget gridItemViewr({
  required int crossAxisItemsCount,
  required Axis scrollDirectionAxis,
  required List<FoodItem> itemLength,
}) {
  return GridView.builder(
      scrollDirection: scrollDirectionAxis,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisItemsCount,
      ),
      itemCount: itemLength.length,
      itemBuilder: (BuildContext context, int index) {
        final items = itemLength[index];

        return FoodTile(
          foodItem: items,
          itemName: items.itemName,
          itemPrice: items.itemPrice,
          itemUrl: items.itemUrl,
        );
      });
}

// ***************************************************************//
// ####################   Slider VIEW    ##########################//
Widget itemsSliderView({
  required List<FoodItem> itemLength,
  required bool? autoPlay,
  required int? timeDuration,
  required double itemHeight,
  required double? viewportFraction,
}) {
  return Center(
    child: CarouselSlider.builder(
        itemCount: itemLength.length,
        options: CarouselOptions(
          height: itemHeight,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          autoPlay: autoPlay!,
          autoPlayInterval: Duration(seconds: timeDuration!),
          viewportFraction: viewportFraction!,
        ),
        itemBuilder: (context, index, realIndex) {
          final foodItem = itemLength[index];

          return FoodTile(
              foodItem: foodItem,
              itemName: foodItem.itemName,
              itemPrice: foodItem.itemPrice,
              itemUrl: foodItem.itemUrl);
        }),
  );
}
