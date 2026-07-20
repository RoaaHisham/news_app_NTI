import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/home_cubit.dart';
import '../../view_model/home_state.dart';
import '../widgets/image_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..intent(FetchNewsIntent()),
      child: Scaffold(
        backgroundColor: Color(0xff202020),
        appBar: AppBar(
          backgroundColor: Color(0xff1877F2),
          title: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            switch (state) {
              case HomeInitial():
                return SizedBox.shrink();
              case HomeLoading():
                return Center(child: CircularProgressIndicator());
              case HomeSuccess():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ImageItemWidget(
                      image: state.articles[index].urlToImage,
                      title: state.articles[index].title,
                      onTap: () {},
                    );
                  },
                  itemCount: state.articles.length,
                );
              case HomeError():
                return Center(child: Text(state.messageError));
            }
          },
        ),
        //     isLoading ? Center(child: CircularProgressIndicator(),)
        //         :messageError == null? ListView.builder(
        //   itemBuilder: (context, index) {
        //     return ImageItemWidget(
        //       image: articles[index].urlToImage ?? dummyImage,
        //       title:articles[index].title ?? "NO TITLE",
        //       onTap: () {},
        //     );
        //   },
        //   itemCount: 30,
        // ): Text(messageError!)
      ),
    );

    // return FutureBuilder(future: ApiService.getNews(), builder:
    // (context,snapshot){
    //   if(snapshot.connectionState == ConnectionState.waiting){
    //     return
    //       Scaffold(
    //       backgroundColor: Color(0xff202020),
    //       appBar: AppBar(
    //         backgroundColor: Color(0xff1877F2),
    //         title: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
    //         centerTitle: true,
    //       ),
    //       body:Center(child: CircularProgressIndicator(),)
    //     );
    //   }
    //
    //   if(snapshot.hasError){
    //     return Scaffold(
    //       backgroundColor: Color(0xff202020),
    //       appBar: AppBar(
    //         backgroundColor: Color(0xff1877F2),
    //         title: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
    //         centerTitle: true,
    //       ),
    //       body:
    //       Center(
    //         child: Text("ERROR",style: TextStyle(fontSize: 40,fontWeight: .bold,color: Colors.red),),
    //       )
    //     );
    //   }
    //
    //
    //   return
    //     Scaffold(
    //     backgroundColor: Color(0xff202020),
    //     appBar: AppBar(
    //       backgroundColor: Color(0xff1877F2),
    //       title: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
    //       centerTitle: true,
    //     ),
    //     body: ListView.builder(
    //       itemBuilder: (context, index) {
    //         var data = snapshot.data?.articles![index];
    //         return ImageItemWidget(
    //           image: data!.urlToImage ?? dummyImage,
    //           title:data.title ?? "NO TITLE",
    //           onTap: () {},
    //         );
    //       },
    //       itemCount: 30,
    //     ),
    //   );
    //
    // }
    // );
  }

  //
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
