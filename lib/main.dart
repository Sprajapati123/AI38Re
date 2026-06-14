import 'package:ai38re/constants/colors.dart';
import 'package:ai38re/constants/image.dart';
import 'package:ai38re/repo/product_repo.dart';
import 'package:ai38re/repo/product_repo_impl.dart';
import 'package:ai38re/view/home_screen.dart';
import 'package:ai38re/viewmodel/product_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductRepo>(create: (_)=> ProductRepoImpl()),

        ChangeNotifierProvider(
          create: (context) =>
              ProductViewModel(productRepo: context.read<ProductRepo>()),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: black),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
