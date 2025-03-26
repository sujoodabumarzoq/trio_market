import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/auth_repository.dart';
import 'package:trio_market/cubit/ResetPassword/reset_password_cubit.dart';
import 'package:trio_market/cubit/signup/signup_cubit.dart';
import 'package:trio_market/cubit/login/login_cubit.dart';
import 'package:trio_market/screen/LoginScreen.dart';
import 'package:trio_market/screen/ResetPasswordScreen.dart';
import 'package:trio_market/screen/SignupScreen.dart';
import 'package:trio_market/screen/SplashScreen.dart';
import 'package:trio_market/screen/buyer/buyer_home_screen.dart';
import 'package:trio_market/screen/buyer/product_details_screen.dart';
import 'package:trio_market/screen/cart/cart_screen.dart';
import 'package:trio_market/screen/checkout_screen/checkout_screen.dart';
import 'package:trio_market/screen/favorites_screen/favorites_screen.dart';
import 'package:trio_market/screen/order_history_screen/order_history_screen.dart';
import 'package:trio_market/screen/order_tracking_screen/order_tracking_screen.dart';
import 'package:trio_market/screen/search_screen/search_screen.dart';


void main() {
  runApp(const TrioMarketApp());
}

class TrioMarketApp extends StatelessWidget {
  const TrioMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrioMarket',
      theme: ThemeData(
        primaryColor: const Color(0xFF1976D2),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1976D2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      initialRoute: '/buyer_home',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => BlocProvider(
          create: (context) => LoginCubit(AuthRepository()),
          child: LoginScreen(),
        ),
        '/signup': (context) => BlocProvider(
          create: (context) => SignUpCubit(AuthRepository()),
          child: SignUpScreen(),
        ),
        '/reset-password': (context) => BlocProvider(
          create: (context) => ResetPasswordCubit(AuthRepository()),
          child: ResetPasswordScreen(),
        ),
        '/buyer_home': (context) => const BuyerHomeScreen(),
        // '/seller_home': (context) => const SellerHomeScreen(),
        // '/delivery_home': (context) => const DeliveryHomeScreen(),
        '/product_details': (context) => ProductDetailsScreen(
          productId: ModalRoute.of(context)!.settings.arguments as int,
        ),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => CheckoutScreen(
          productId: ModalRoute.of(context)!.settings.arguments as int,
        ),
        '/order_tracking': (context) => const OrderTrackingScreen(),
        '/order_history': (context) => const OrderHistoryScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/search': (context) =>  SearchScreen(),
      },
    );
  }
}

// باقي الكود (SellerHomeScreen, DeliveryHomeScreen) زي ما هو