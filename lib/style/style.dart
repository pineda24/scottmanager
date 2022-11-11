import 'package:flutter/material.dart';

class Style {
  /*---------------- C O L O R S ----------------------*/

  // static const Color primaryColor = Color(0xFF0466c8);
  static const Color primaryColor = Color(0xFF004E98);
  static const Color secundaryColor = Color(0xFFffffff);
  // static const Color primaryColor = Color(0xFFFFFFFF);
  // static const Color primaryColorBold = Color(0xFF590d22);
  static const Color primaryColorBold = Color(0xFF40916c);

  static const Color colorSelect = Color(0xFF95d5b2);

  static const Color iconBlackColor = Colors.black;
  static const Color iconGrayColor = Colors.grey;
  static const Color iconWhiteColor = Colors.white;
  static const Color accentColor = Colors.orange;
  static const Color lightGreyColor = Color.fromRGBO(250, 250, 250, 1.0);
  static const Color backgroundColor = Color(0XFFe9ecef);
  static const Color secundaryBackgroundColor =
      Color.fromRGBO(240, 240, 240, 1);

  static Color warnColor = Colors.yellow.shade900;
  static Color warnLightColor = Colors.amberAccent.shade100;
  static Color infoColor = Colors.blue.shade700;
  static Color infoLightColor = Colors.blue.shade200;
  static Color succsessColor = Colors.green.shade800;
  static Color succsessLightColor = Colors.green.shade200;
  static Color dangerColor = Colors.red.shade800;
  static Color dangerLightColor = Colors.red.shade200;

  /*---------------- F O N T  S T Y L E S ----------------------*/

  static const h1 = TextStyle(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500);

  static const h2 = TextStyle(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500);

  static const h3 = TextStyle(
      color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500);

  static const h4 = TextStyle(
      color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w500);

  static const p = TextStyle(
      color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.normal);

  static const blackBigText = TextStyle(
      color: Colors.black, fontSize: 35.0, fontWeight: FontWeight.bold);

  static const whiteBigText = TextStyle(
      color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold);

  static const bigText1 = TextStyle(
      color: Colors.black, fontSize: 45.0, fontWeight: FontWeight.bold);

  static const bigText2 = TextStyle(
      color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold);

  static const bigText3 = TextStyle(
      color: Colors.black, fontSize: 35.0, fontWeight: FontWeight.bold);

  static const blueBigText = TextStyle(
      color: Style.primaryColor, fontSize: 30.0, fontWeight: FontWeight.bold);

  static const blackMediumTextBold = TextStyle(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);

  static const blackMediumText = TextStyle(
      color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.normal);

  static const leadText = TextStyle(
      color: Colors.black87, fontSize: 14.0, fontWeight: FontWeight.w600);

  static const primaryColorLeadText = TextStyle(
      color: Color.fromRGBO(0, 122, 217, 1.0),
      fontSize: 14.0,
      fontWeight: FontWeight.w600);

  static const accentColorleadText = TextStyle(
      color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w600);

  static const promotionCardTitle = TextStyle(
    color: Colors.orange,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const promotionCardDetailTitle = TextStyle(
    color: Colors.orange,
    fontSize: 50,
    fontWeight: FontWeight.bold,
  );

  static const leadTextBold = TextStyle(
      color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold);

  static const smallLeadText = TextStyle(
      color: Colors.black38, fontSize: 12.0, fontWeight: FontWeight.w600);

  static const smallLeadTextbold = TextStyle(
      color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold);

  static const smallLeadWhiteTextbold = TextStyle(
      color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold);

  static const blackSmallText = TextStyle(color: Colors.black, fontSize: 15.0);

  static const blackSmallTextBold = TextStyle(
      color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold);

  static const whiteSmallText = TextStyle(color: Colors.white, fontSize: 10.0);

  static const whiteNormalText = TextStyle(
    color: Colors.white,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
  );

  static const acentNormalText = TextStyle(
    color: Color(0xFF0466c8),
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
  );

  static const acentNormalTextButton = TextStyle(
    color: primaryColorBold,
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
  );

  static const greyNormalText = TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
  );

  static const blackNormalText = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
  );

  static const whiteNormalBoldText = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static const blackNormalBoldText = TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static const blackSmallBold = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

  static const blackSmallNormal = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );

  static const greySmallNormal = TextStyle(
    color: Colors.grey,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );

  static const whiteSmallBold = TextStyle(
    color: Colors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

  static const whiteSmallNormal = TextStyle(
    color: Colors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );

  static const blackNormalw800Text = TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
  );

  static const breadCrumbTextStyle = TextStyle(
      color: Color.fromRGBO(0, 122, 217, 1.0),
      fontSize: 10,
      fontWeight: FontWeight.w500);

  /*---------------- F O R M  S T Y L E S ----------------------*/

  static const formTextLight = TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat');

  static const formTextDisabledLight = TextStyle(
      color: Colors.grey,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat');

  static const buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)));

  static const buttonTextStyleWhite =
      TextStyle(color: Colors.white, fontSize: 18);

/*---------------- C O M M O N ----------------------*/
  static const mainIconSize = 35.0;

  static const borderRounded = BorderRadius.all(Radius.circular(5.0));

  static const borderCircle = BorderRadius.all(Radius.circular(100.0));

  static const borderBottomRounded =
      BorderRadius.vertical(bottom: Radius.circular(10.0));
  static const borderTopRounded =
      BorderRadius.vertical(top: Radius.circular(10.0));

  static const borderLeftRounded =
      BorderRadius.horizontal(left: Radius.circular(5.0));
}
