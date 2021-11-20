import 'package:notes/_app_packages.dart';
import 'package:notes/_internal_packages.dart';

Widget home(
    final BuildContext context,
    final Color _backgroundColor,
    final Function() onScreenTap,
    final Function() onGetStartTap,
    final double _headingTop,
    final Color _headingColor) {
  return AnimatedContainer(
    curve: Curves.fastLinearToSlowEaseIn,
    duration: const Duration(milliseconds: 1000),
    height: MediaQuery.of(context).size.height,
    color: _backgroundColor,
    child: Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: onScreenTap,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 1000),
                    margin: EdgeInsets.only(
                      top: _headingTop,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Keep ',
                          style: TextStyle(
                            color: _headingColor,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Notes',
                          style: TextStyle(
                              color: _headingColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    Language.of(context).appTagLine,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _headingColor, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(
            32,
          ),
          child: Center(
            child: Image.asset('assets/images/splash_bg.png'),
          ),
        ),
        SizedBox(
          child: GestureDetector(
            onTap: onGetStartTap,
            child: Container(
              margin: const EdgeInsets.all(32),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  Language.of(context).getStarted,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}