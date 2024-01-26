import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:web_app/Utils/colors.dart';
import 'package:web_app/Utils/view_wrapper.dart';
import 'package:web_app/provider_function/logic_function.dart';
//  import 'package:web_app/screen/about_view.dart';
import 'package:web_app/screen/cart_view.dart';
import 'package:web_app/bottom_bar.dart';
import 'package:web_app/content_view.dart';
import 'package:web_app/custom_tab.dart';
import 'package:web_app/screen/create_item_view.dart';
import 'package:web_app/screen/foodItems_view.dart';
import 'package:web_app/screen/order_view.dart';
//  import 'package:web_app/screen/home_view.dart';
import 'package:web_app/screen/update_item_view.dart';
import 'package:web_app/widgets/background.dart';
import 'custom_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ItemScrollController _itemScrollController;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  late double screenwidth;
  late double screenHeight;
  late double topPadding;
  late double bottomPadding;
  late TabController tabController;
  List<ContentView> contentViews = [
    ContentView(
      tab: const CustomTab(
        isShowCount: true,
        title: "Orders ",
        //context.watch<OrderFoodItems>().listOfOrder.length,
        iconData: Icons.add_shopping_cart_sharp,
      ),
      content: const OrderView(),
    ),

    ContentView(
      tab: const CustomTab(
        isShowCount: false,
        title: "Food",
      ),
      content: const FoodItemsView(),
    ),

    ContentView(
      tab: const CustomTab(
        isShowCount: false,
        title: "Update Item",
      ),
      content: const UpdateDeleteItem(),
    ),
    ContentView(
      tab: const CustomTab(
        isShowCount: false,
        title: "Create",
      ),
      content: const CreateItem(),
    ),

    // ContentView(
    //   tab: const CustomTab(
    //     isShowCount: false,
    //     title: "Home",
    //   ),
    //   content: const HomeView(),
    // ),

    // ContentView(
    //   tab: const CustomTab(
    //     isShowCount: false,
    //     title: "About",
    //   ),
    //   content: const AboutView(),
    // ),

    // ContentView(
    //   tab: const CustomTab(
    //     isShowCount: true,
    //     title: "Cart ",
    //     iconData: Icons.add_shopping_cart_sharp,
    //   ),
    //   content: const CartView(),
    // ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
    _itemScrollController = ItemScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.01;

    return Background(
      backgroundURL: "img/background1.jpg",
      child: Scaffold(
        backgroundColor: Colors.transparent,
        endDrawer: drawer(),
        key: scaffoldkey,
        body: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding, top: topPadding),
          child: ViewWrapper(
            desktopView: desktopView(),
            mobileView: mobileView(),
          ),
        ),
      ),
    );
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTabBar(
          controller: tabController,
          tabs: contentViews.map((e) => e.tab).toList(),
        ),
        Container(
          height: screenHeight * 0.8,
          child: TabBarView(
            controller: tabController,
            children: contentViews.map((e) => e.content).toList(),
          ),
        ),
        BottomBar(),
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding:
          EdgeInsets.only(left: screenwidth * 0.05, right: screenwidth * 0.05),
      child: SizedBox(
        width: screenwidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${context.watch<OrderFoodItems>().listOfOrder.length}",
                  style: TextStyle(color: MyColor.myRed, fontSize: 30),
                ),
                IconButton(
                    onPressed: () {
                      _itemScrollController.jumpTo(index: 3);
                    },
                    icon: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: MyColor.myOrange,
                    )),
                IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  color: MyColor.myOrange,
                  iconSize: screenwidth * 0.08,
                  onPressed: () {
                    scaffoldkey.currentState?.openEndDrawer();
                  },
                ),
              ],
            ),
            Expanded(
                child: ScrollablePositionedList.builder(
                    itemScrollController: _itemScrollController,
                    itemCount: contentViews.length,
                    itemBuilder: (context, index) =>
                        contentViews[index].content)),
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      surfaceTintColor: MyColor.myOrange,
      shadowColor: Colors.black,
      backgroundColor: Colors.black,
      child: ListView(
        children: [
              Container(
                height: screenHeight * 0.1,
              )
            ] +
            contentViews
                .map((e) => Container(
                      child: ListTile(
                        title: Text(
                          e.tab.title,
                          style: TextStyle(color: MyColor.myOrange),
                        ),
                        onTap: () {
                          _itemScrollController.scrollTo(
                              index: contentViews.indexOf(e),
                              duration: const Duration(milliseconds: 300));
                          Navigator.pop(context);
                        },
                      ),
                    ))
                .toList(),
      ),
    );
  }
}
