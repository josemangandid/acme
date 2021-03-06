import 'package:acme/app/data/provider/provider.dart';
import 'package:acme/app/glogal_widgets/shared_preferences.dart';
import 'package:acme/app/routes/routes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:share_plus/share_plus.dart';

class GC extends GetxController {
  final p = PrefsUser();
  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;
  Future<void> signOut() async {
    await _auth.signOut();
    p.authValue = false;
    p.userid = '';
    Get.offNamed(Routes.singin);
  }

  @override
  void onInit() {
    _auth.userChanges().listen((event) => user = event);
    _initDynamicLinks();
    super.onInit();
  }

  checkConection(BuildContext context) async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      Get.offNamed(p.authValue ? Routes.home : Routes.singin);
    } else {
      showD(context);
    }
  }

  showD(BuildContext _) async {
    switch (await showDialog(
      barrierDismissible: false,
      context: _,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text('¡Atención!'),
        content: const Text('No hay conexión a internet...'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(_, 'fun');
            },
            child: const Text('¿Reintentar?'),
          ),
        ],
      ),
    )) {
      case 'fun':
        checkConection(_);
        break;
    }
  }

  final provider = Provider();

  void _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;

          if (deepLink != null) {
            Get.offNamed(Routes.contestarencuesta, arguments: deepLink);
          }
        },
        onError: (OnLinkErrorException e) async {});

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Get.offNamed(Routes.contestarencuesta, arguments: deepLink);
    }
  }

  withLink(String uri) async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(uri));
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      Get.offNamed(Routes.contestarencuesta, arguments: deepLink);
    }
  }

  Future<void> createDynamicLink(String uid, String encuestaid) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://acmetest.page.link',
      link: Uri.parse(
          'https://ecmaencuesta-default-rtdb.firebaseio.com/$uid/encuestas/$encuestaid.json'),
      androidParameters: AndroidParameters(
        packageName: 'com.devel.acme',
        minimumVersion: 1,
      ),
    );

    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;

    void share() async {
      Share.share(shortUrl.toString());
    }

    share();
  }
}
