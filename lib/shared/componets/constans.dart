import 'package:shop_app/shared/componets/widgets.dart';

import '../../modules/login/login_screen.dart';
import '../network/local/shared_preferences.dart';

String token='';

int? lastItemAdded=0;


void logout({
  required context
})
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      navigatorPushAndRemove(context: context, widget: LoginScreen());
    }
  }).catchError((error)
  {
    print('logout error $error');
  });
}