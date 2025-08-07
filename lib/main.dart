import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(AiQApp());
}

class AiQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AiQ - Elite Athletic Performance Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/features',
      builder: (BuildContext context, GoRouterState state) {
        return FeaturesPage();
      },
    ),
    GoRoute(
      path: '/pricing',
      builder: (BuildContext context, GoRouterState state) {
        return PricingPage();
      },
    ),
    GoRoute(
      path: '/assessment',
      builder: (BuildContext context, GoRouterState state) {
        return AssessmentPage();
      },
    ),
  ],
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E293B),
              Color(0xFF334155),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AiQNavBar(),
              HeroSection(fadeAnimation: _fadeAnimation),
              FeaturesSection(),
              HowItWorksSection(),
              CTASection(),
            ],
          ),
        ),
      ),
    );
  }
}

class AiQNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWideScreen ? 32 : 16, 
        vertical: 16
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0EA5E9), Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'AQ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF8B5CF6)],
                ).createShader(bounds),
                child: Text(
                  'AiQ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (isWideScreen) Row(
            children: [
              NavLink('Features', '/features'),
              SizedBox(width: 32),
              NavLink('Pricing', '/pricing'),
              SizedBox(width: 32),
              NavLink('About', '/'),
              SizedBox(width: 32),
              ElevatedButton(
                onPressed: () => context.go('/assessment'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Start Free Trial',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ) else IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class NavLink extends StatelessWidget {
  final String text;
  final String route;

  NavLink(this.text, this.route);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final Animation<double> fadeAnimation;

  HeroSection({required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 768;
    
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? 32 : 16,
              vertical: isWideScreen ? 80 : 40,
            ),
            child: isWideScreen 
              ? Row(
                  children: [
                    Expanded(flex: 1, child: HeroTextContent()),
                    SizedBox(width: 64),
                    Expanded(flex: 1, child: DashboardPreview()),
                  ],
                )
              : Column(
                  children: [
                    HeroTextContent(),
                    SizedBox(height: 40),
                    DashboardPreview(),
                  ],
                ),
          ),
        );
      },
    );
  }
}

class HeroTextContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 768;
    
    return Column(
      crossAxisAlignment: isWideScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF3B82F6).withOpacity(0.1),
            border: Border.all(color: Color(0xFF3B82F6).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.rocket_launch, color: Color(0xFF0EA5E9), size: 16),
              SizedBox(width: 8),
              Text(
                'AI-Powered Athletic Training',
                style: TextStyle(
                  color: Color(0xFF0EA5E9),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
        Text(
          'Elite Athletic Performance with AiQ Intelligence',
          style: TextStyle(
            fontSize: isWideScreen ? 48 : 32,
            fontWeight: FontWeight.w800,
            height: 1.1,
            color: Colors.white,
          ),
          textAlign: isWideScreen ? TextAlign.start : TextAlign.center,
        ),
        SizedBox(height: 24),
        Text(
          'Transform your training with science-based assessments, personalized workout prescriptions, and intelligent performance tracking. Used by elite athletes worldwide.',
          style: TextStyle(
            fontSize: isWideScreen ? 20 : 16,
            color: Colors.white.withOpacity(0.8),
            height: 1.6,
          ),
          textAlign: isWideScreen ? TextAlign.start : TextAlign.center,
        ),
        SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/assessment'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Color(0xFFFF6B35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Start Your Assessment',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                side: BorderSide(color: Colors.white.withOpacity(0.2), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Watch Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.play_arrow, color: Colors.white, size: 18),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DashboardPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 500),
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Color(0xFF1E293B).withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 25,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Athlete Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '94',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              MetricCard('87%', 'Power'),
              MetricCard('92%', 'Recovery'),
              MetricCard('5', 'Workouts'),
              MetricCard('15', 'Day Streak'),
            ],
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Ready for Elite Training',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String value;
  final String label;

  MetricCard(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF3B82F6).withOpacity(0.1),
        border: Border.all(color: Color(0xFF3B82F6).withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF0EA5E9),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 1200;
    final isMediumScreen = MediaQuery.of(context).size.width > 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMediumScreen ? 32 : 16,
        vertical: isMediumScreen ? 96 : 48,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF8B5CF6).withOpacity(0.1),
              border: Border.all(color: Color(0xFF8B5CF6).withOpacity(0.3)),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fitness_center, color: Color(0xFF8B5CF6), size: 16),
                SizedBox(width: 8),
                Text(
                  'Professional Features',
                  style: TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Everything You Need for Peak Performance',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMediumScreen ? 56 : 32,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Comprehensive training platform designed by sports scientists for elite athletes and coaches',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: isMediumScreen ? 20 : 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              if (isWideScreen) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: FeatureCard(
                      icon: Icons.psychology,
                      title: 'AI-Powered Assessments',
                      description: '6-pillar coherence evaluation system that analyzes movement quality, power, recovery, nutrition, mental fitness, and EMS usage.',
                      features: [
                        'Personalized athlete profiling',
                        'Science-based evaluation metrics',
                        'Real-time coherence scoring',
                        'Progress tracking and analytics',
                      ],
                    )),
                    SizedBox(width: 32),
                    Expanded(child: FeatureCard(
                      icon: Icons.fitness_center,
                      title: 'Intelligent Workout Generation',
                      description: '4-6 exercise full-body circuits tailored to your goals, equipment, and experience level with integrated EMS protocols.',
                      features: [
                        'Equipment-aware exercise selection',
                        'Goal-specific programming',
                        'EMS integration for enhanced results',
                        'Professional exercise database',
                      ],
                    )),
                    SizedBox(width: 32),
                    Expanded(child: FeatureCard(
                      icon: Icons.analytics,
                      title: 'Performance Analytics',
                      description: 'Comprehensive tracking and analysis of your training data with actionable insights for continuous improvement.',
                      features: [
                        'Workout history and trends',
                        'Performance benchmarking',
                        'Recovery monitoring',
                        'Goal achievement tracking',
                      ],
                    )),
                  ],
                );
              } else {
                return Column(
                  children: [
                    FeatureCard(
                      icon: Icons.psychology,
                      title: 'AI-Powered Assessments',
                      description: '6-pillar coherence evaluation system that analyzes movement quality, power, recovery, nutrition, mental fitness, and EMS usage.',
                      features: [
                        'Personalized athlete profiling',
                        'Science-based evaluation metrics',
                        'Real-time coherence scoring',
                        'Progress tracking and analytics',
                      ],
                    ),
                    SizedBox(height: 32),
                    FeatureCard(
                      icon: Icons.fitness_center,
                      title: 'Intelligent Workout Generation',
                      description: '4-6 exercise full-body circuits tailored to your goals, equipment, and experience level with integrated EMS protocols.',
                      features: [
                        'Equipment-aware exercise selection',
                        'Goal-specific programming',
                        'EMS integration for enhanced results',
                        'Professional exercise database',
                      ],
                    ),
                    SizedBox(height: 32),
                    FeatureCard(
                      icon: Icons.analytics,
                      title: 'Performance Analytics',
                      description: 'Comprehensive tracking and analysis of your training data with actionable insights for continuous improvement.',
                      features: [
                        'Workout history and trends',
                        'Performance benchmarking',
                        'Recovery monitoring',
                        'Goal achievement tracking',
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;

  FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Color(0xFF1E293B).withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0EA5E9), Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 32),
            ),
          ),
          SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              height: 1.6,
            ),
          ),
          SizedBox(height: 24),
          ...features.map((feature) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, color: Color(0xFF10B981), size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}

class HowItWorksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMediumScreen = MediaQuery.of(context).size.width > 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMediumScreen ? 32 : 16,
        vertical: isMediumScreen ? 96 : 48,
      ),
      color: Color(0xFF0F172A).withOpacity(0.5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF10B981).withOpacity(0.1),
              border: Border.all(color: Color(0xFF10B981).withOpacity(0.3)),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flash_on, color: Color(0xFF10B981), size: 16),
                SizedBox(width: 8),
                Text(
                  'Simple Process',
                  style: TextStyle(
                    color: Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Get Started in 4 Easy Steps',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMediumScreen ? 56 : 32,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'From assessment to elite performance in minutes',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: isMediumScreen ? 20 : 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return Row(
                  children: [
                    Expanded(child: StepCard('1', 'Create Athlete Profile', 'Input basic information including sport, position, experience level, and training goals.')),
                    SizedBox(width: 32),
                    Expanded(child: StepCard('2', 'Complete Assessment', 'Take our comprehensive 6-pillar coherence evaluation to analyze your current abilities.')),
                    SizedBox(width: 32),
                    Expanded(child: StepCard('3', 'Get AI Prescription', 'Receive personalized workout plan with exercises, sets, reps, and EMS protocols.')),
                    SizedBox(width: 32),
                    Expanded(child: StepCard('4', 'Train & Track', 'Execute your workout plan and track progress with our intelligent analytics system.')),
                  ],
                );
              } else if (constraints.maxWidth > 768) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: StepCard('1', 'Create Athlete Profile', 'Input basic information including sport, position, experience level, and training goals.')),
                        SizedBox(width: 32),
                        Expanded(child: StepCard('2', 'Complete Assessment', 'Take our comprehensive 6-pillar coherence evaluation to analyze your current abilities.')),
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(child: StepCard('3', 'Get AI Prescription', 'Receive personalized workout plan with exercises, sets, reps, and EMS protocols.')),
                        SizedBox(width: 32),
                        Expanded(child: StepCard('4', 'Train & Track', 'Execute your workout plan and track progress with our intelligent analytics system.')),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    StepCard('1', 'Create Athlete Profile', 'Input basic information including sport, position, experience level, and training goals.'),
                    SizedBox(height: 32),
                    StepCard('2', 'Complete Assessment', 'Take our comprehensive 6-pillar coherence evaluation to analyze your current abilities.'),
                    SizedBox(height: 32),
                    StepCard('3', 'Get AI Prescription', 'Receive personalized workout plan with exercises, sets, reps, and EMS protocols.'),
                    SizedBox(height: 32),
                    StepCard('4', 'Train & Track', 'Execute your workout plan and track progress with our intelligent analytics system.'),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class StepCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  StepCard(this.number, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class CTASection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMediumScreen = MediaQuery.of(context).size.width > 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMediumScreen ? 32 : 16,
        vertical: isMediumScreen ? 96 : 48,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          padding: EdgeInsets.all(isMediumScreen ? 64 : 32),
          decoration: BoxDecoration(
            color: Color(0xFF1E293B).withOpacity(0.9),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Text(
                'Ready to Unlock Your Athletic Potential?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMediumScreen ? 40 : 28,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                'Join thousands of elite athletes using AiQ to optimize their training and achieve peak performance.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: isMediumScreen ? 20 : 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go('/assessment'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMediumScreen ? 40 : 32,
                    vertical: 20,
                  ),
                  backgroundColor: Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Start Your Free Assessment',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: isMediumScreen ? 20 : 16,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.rocket_launch, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder pages for routing
class FeaturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Features'),
        backgroundColor: Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Features Page - Coming Soon',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class PricingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pricing'),
        backgroundColor: Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pricing Page - Coming Soon',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class AssessmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment'),
        backgroundColor: Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment, color: Colors.white, size: 64),
            SizedBox(height: 20),
            Text(
              'AiQ Assessment Portal',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Your 6-pillar athletic evaluation starts here!',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6B35),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                'Back to Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}