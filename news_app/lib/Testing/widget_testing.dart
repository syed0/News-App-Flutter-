import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/app_constants.dart';
import 'package:news_app/main.dart';



void main(){
  testWidgets("Testing show more Button", ( WidgetTester tester) async{
    // Widgets
    // final showMoreBtn = find.byKey(ValueKey(AppConstants.instance.showMoreBtnKey));
    // final webView = find.byKey(ValueKey(AppConstants.instance.webViewKey));


    //executing the actual step
    await tester.pumpWidget(MyApp());
    //await tester.tap(showMoreBtn);
    await tester.pump();


    //check outputs
    expect(find.text("Show more"), findsOneWidget);
  });
}
