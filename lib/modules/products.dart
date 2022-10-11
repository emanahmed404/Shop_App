import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categoriesmodel.dart';
import 'package:shopapp/models/homemodel.dart';
import 'package:shopapp/modules/appcubit/appcubit.dart';
import 'package:shopapp/modules/appcubit/appstates.dart';
import 'package:shopapp/shared/components/components.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoriteSuccessState){
           if(!state.model.status!){
             showToast(
                 msg: state.model.message!,
                 state: ToastStates.ERROR,
             );
           }
        }
      },
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: AppCubit.get(context).homeModel !=null && AppCubit.get(context).categoriesModel !=null ,
          builder: (context)=>ProductBuilder(context,AppCubit.get(context).homeModel!, AppCubit.get(context).categoriesModel!),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

}

 Widget ProductBuilder(context,HomeModel homeModel,CategoriesModel categoriesModel)=>SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children:
    [
      CarouselSlider(
        items: homeModel.data!.banners.map((e) =>Image(
          image: NetworkImage('${e.image}'),
          width: double.infinity,
          fit: BoxFit.fill,
        )).toList(),
        options: CarouselOptions(
          height: 300,
          initialPage: 0,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(
                  'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),

            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 100,
              color: Colors.grey[300],
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context ,index)=> buildCategoryItem(categoriesModel.data!.data[index]),
                  separatorBuilder: (context ,index)=> SizedBox(
                    width: 3.0,
                  ),
                  itemCount: categoriesModel.data!.data.length,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'New Products',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1/1.58,
          children: List.generate(
            homeModel.data!.products.length,
                (index) => gridItemBuilder(homeModel.data!.products[index],context),
          ),
        ),
      ),
    ],
  ),
);

 Widget buildCategoryItem(DataModel model)=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(
      image: NetworkImage(model.image),
      width: 100.0,
      height: 100.0,
      fit: BoxFit.cover,
    ),
    Container(
      width: 100.0,
      color: Colors.black.withOpacity(0.8),
      child: Text(
        model.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ],
);

 Widget gridItemBuilder(ProductModel model,context)=>Container(
   color: Colors.white,
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Stack(
         alignment: AlignmentDirectional.bottomStart,
         children: [
           Image(
             image: NetworkImage(model.image),
             width: double.infinity,
             height: 200.0,
           ),
           if(model.discount != 0)
              Container(
             color: Colors.pink,
             padding: EdgeInsets.symmetric(horizontal: 8.0),
             child: Text(
               'DISCOUNT',
               style: TextStyle(
                 fontSize: 8.0,
                 color: Colors.white,
               ),
             ),
           ),
         ],
       ),

       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
                 model.name,
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(
                   fontSize: 14.0,
                   height: 1.5,
                 ),
               ),
             Row(
               children: [
                   Text(
                     '${model.price}',
                     style: TextStyle(
                       fontSize: 14.0,
                       color: Colors.pinkAccent
                     ),
                   ),
                 SizedBox(
                   width: 10.0,
                 ),
                 if(model.discount != 0)
                     Text(
                     '${model.old_price.round()}',
                     style: TextStyle(
                       fontSize: 14.0,
                       color: Colors.grey,
                       decoration :TextDecoration.lineThrough,
                     ),
                   ),
                 Spacer(),
                 IconButton(
                   //  padding: EdgeInsets.zero,
                     onPressed: ()
                     {
                       AppCubit.get(context).changeFavorites(model.id);
                       print(model.id);
                     },
                     icon:AppCubit.get(context).favorites[model.id]!  ?
                     Icon(Icons.favorite , color: Colors.pink,) :  Icon(Icons.favorite_border),
                 ),

               ],
             ),
           ],
         ),
       ),
     ],
   ),
 );
