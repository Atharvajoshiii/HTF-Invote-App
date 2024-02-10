import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invote/color/color.dart';
import 'package:invote/screens/guidelinepage.dart';

import '../Assets/appassets.dart';

class ShoeAppOnboardingPage extends StatefulWidget {
  const ShoeAppOnboardingPage({Key? key}) : super(key: key);

  @override
  State<ShoeAppOnboardingPage> createState() => _ShoeAppOnboardingPageState();
}

class _ShoeAppOnboardingPageState extends State<ShoeAppOnboardingPage> {
  int _currentIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLightWhite,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFCC99), // Saffron
              Colors.white, // White
              Color(0xFF8BC34A), // Green
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.5, 0.7],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OnboardingCard(
                      image: "images/modiji.jpg",
                      playAnimation: true,
                      title: 'Welcome To InVote',
                      description: 'India\'s trusted online voting platform.\nCast your vote from anywhere, anytime.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: OnboardingCard(
                      image: "images/electioncommision.png",
                      playAnimation: true,
                      title: 'Empowering Democracy',
                      description: 'Participate in the democratic process and make your voice heard.Every vote counts!',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: OnboardingCard(
                      image: "images/onboarding2.jpg",
                      playAnimation: true,
                      title: 'Secure & Convenient',
                      description: 'Our platform ensures the security and integrity of your vote.Voting made easy for all citizens.',
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularIconButton(
                  onTap: _currentIndex > 0
                      ? () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastEaseInToSlowEaseOut,
                    );
                  }
                      : null,
                  icon: AppAssets.kDirectionLeft,
                ),
                const SizedBox(width: 28),
                RichText(
                  text: TextSpan(
                    text: ' $_currentIndex / ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kPrimary,
                    ),
                    children: const [
                      TextSpan(
                        text: '3',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                CircularIconButton(
                  onTap: () {
                    if (_currentIndex <= 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GuidelinePage()));
                    }
                  },
                  icon: AppAssets.kDirectionRight,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class BouncingAnimation extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  const BouncingAnimation({
    required this.child,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<BouncingAnimation> createState() => _BouncingAnimationState();
}

class _BouncingAnimationState extends State<BouncingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          _controller.forward().then((_) {
            _controller.reverse();
          });
          widget.onTap!();
        }
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

class CircularIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String icon;
  const CircularIconButton({
    required this.onTap,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingAnimation(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.kLightWhite,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.25),
            )
          ],
        ),
        child: SvgPicture.asset(
          icon,
          color: onTap != null
              ? AppColors.kPrimary
              : AppColors.kPrimary.withOpacity(0.1),
        ),
      ),
    );
  }
}
class OnboardingCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final bool playAnimation;
  const OnboardingCard({
    required this.playAnimation,
    required this.image,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingCard> createState() => _OnboardingCardState();
}

class _OnboardingCardState extends State<OnboardingCard>
    with TickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;

  Animation<Offset> get slideAnimation => _slideAnimation;
  AnimationController get slideAnimationController => _slideAnimationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.playAnimation) {
      _slideAnimationController.forward();
    } else {
      _slideAnimationController.animateTo(
        1,
        duration: const Duration(milliseconds: 0),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _slideAnimationController =
        OnboardingAnimations.createSlideController(this);
    _slideAnimation = OnboardingAnimations.openSpotsSlideAnimation(
        _slideAnimationController);
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        children: [
          const SizedBox(height: 96),
          ClipOval(
            child: Image.asset(
              widget.image,
              width: 300, // Adjust width according to your design
              height: 300, // Adjust height according to your design
              fit: BoxFit.cover,
            ),
          ),
          const Spacer(),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingAnimations {
  static AnimationController createSlideController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1000),
    );
  }

  static Animation<Offset> openSpotsSlideAnimation(
      AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.0, -0.8),
      end: const Offset(0.0, -0.05),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const ElasticOutCurve(1.2),
    ));
  }
}
