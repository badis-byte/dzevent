import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:dzevent/presentation/widgets/mainContainerUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  var formkey = GlobalKey<FormState>();
  bool association = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passOneController = TextEditingController();
  var passTwoController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFF8F9FC),
              const Color(0xFFFFFFFF),
              const Color(0xFFF0F4FF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        // Header with icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF667EEA).withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_add_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Create New Account",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Join us and discover amazing events",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 32),
                        googleButton(loc),
                        const SizedBox(height: 24),
                        orDevider(loc),
                        const SizedBox(height: 28),
                        buildInput(
                          loc: loc,
                          label: "Full Name",
                          hint: "Enter your full name",
                          pass: false,
                          icon: Icons.person_outline_rounded,
                          textcontroller: nameController,
                          validate: _nameValidate,
                        ),
                        const SizedBox(height: 18),
                        buildInput(
                          loc: loc,
                          label: "Email Address",
                          hint: "Enter your email address",
                          pass: false,
                          icon: Icons.email_outlined,
                          textcontroller: emailController,
                          validate: _emailValidate,
                        ),
                        const SizedBox(height: 18),
                        buildInput(
                          loc: loc,
                          label: "Password",
                          hint: "Enter your password",
                          pass: true,
                          icon: Icons.lock_outline_rounded,
                          textcontroller: passOneController,
                          validate: _passOneValidate,
                        ),
                        const SizedBox(height: 18),
                        buildInput(
                          loc: loc,
                          label: "Confirm Password",
                          hint: "Confirm your password",
                          pass: true,
                          icon: Icons.lock_outline_rounded,
                          textcontroller: passTwoController,
                          validate: _passTwoValidate,
                        ),
                        const SizedBox(height: 24),
                        // Association checkbox - redesigned
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: association 
                                  ? const Color(0xFF667EEA) 
                                  : const Color(0xFFE8ECF4),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: association
                                    ? const Color(0xFF667EEA).withOpacity(0.1)
                                    : Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: association
                                      ? const Color(0xFF667EEA).withOpacity(0.1)
                                      : const Color(0xFFF7FAFC),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.business_rounded,
                                  color: association
                                      ? const Color(0xFF667EEA)
                                      : Colors.grey[400],
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  "Are you an Association?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: association
                                        ? const Color(0xFF667EEA)
                                        : const Color(0xFF2D3748),
                                  ),
                                ),
                              ),
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  value: association,
                                  onChanged: (value) {
                                    setState(() {
                                      print(value);
                                      association = value!;
                                    });
                                  },
                                  activeColor: const Color(0xFF667EEA),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        createButton(loc),
                        const SizedBox(height: 24),
                        yesAccount(loc),
                        const SizedBox(height: 20),
                        policy(loc),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget yesAccount(AppLocalizations loc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          loc.alreadyHaveAccount,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () => {Navigator.pushNamed(context, "/login")},
          child: Text(
            " ${loc.logIn}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF667EEA),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget policy(AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            loc.byCreatingAccount,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              " ${loc.termsOfService}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF667EEA),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            " ${loc.and}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              " ${loc.privacyPolicy}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF667EEA),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createButton(AppLocalizations loc) {
    return BlocConsumer<AccountCubit, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) {
          return Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child:  Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ),
            ),
          );
        }
        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667EEA).withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              print('create account button pressed!');
              _process();
            },
            child: const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AccountGuest) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => EventFeed()),
          );
        } else if (state is AccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: const Color(0xFFFF6B6B),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else if (state is AccountExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Email already exists"),
              backgroundColor: const Color(0xFFFF6B6B),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else if (state is UserFetched) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainContainerUser()),
          );
        }
      },
    );
  }

  Column buildInput({
    required AppLocalizations loc,
    required String label,
    required String hint,
    required bool pass,
    required IconData icon,
    required TextEditingController textcontroller,
    required String? Function(String?)? validate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF2D3748),
              letterSpacing: 0.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: textcontroller,
            validator: validate,
            obscureText: pass,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D3748),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF667EEA),
                  size: 20,
                ),
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFFE8ECF4),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF667EEA),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFFF6B6B),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFFF6B6B),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row orDevider(AppLocalizations loc) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.grey.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "or",
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget googleButton(AppLocalizations loc) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE8ECF4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: const Color(0xFF2D3748),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () => print('google button pressed!'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google1.png", height: 24, width: 24),
            const SizedBox(width: 12),
            Text(
              loc.continueWithGoogle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _nameValidate(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "Name is required";
    }

    final parts = text.trim().split(RegExp(r'\s+'));

    if (parts.length < 2) {
      return "Please enter your full name (first and last)";
    }

    if (parts.any((part) => part.length < 2)) {
      return "Each name must be at least 2 characters";
    }

    return null;
  }

  String? _emailValidate(String? text) {
    if (text == null || text.isEmpty) {
      return "Email is required";
    }
    //added just for easy testing ------------
    final regeX = RegExp(r'^email\d+$');
    if(regeX.hasMatch(text)){return null;}
    //---------------------------------------

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (!regex.hasMatch(text)) {
      return "Enter a valid email";
    }

    return null;
  }

  String? _passOneValidate(String? text) {
    if (text == null || text.isEmpty) {
      return "Password is required";
    }
    //added just for easy testing--------
    if(text == "pass"){return null;}
    //-----------------------------------
    if (text.length < 8) {
      return "Password must be at least 8 characters long";
    }

    if (!RegExp(r'[A-Z]').hasMatch(text)) {
      return "Password must contain at least one uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(text)) {
      return "Password must contain at least one lowercase letter";
    }

    if (!RegExp(r'[0-9]').hasMatch(text)) {
      return "Password must contain at least one number";
    }

    return null;
  }

  String? _passTwoValidate(String? text) {
    if (text == null || text.isEmpty) {
      return "Please confirm your password";
    }

    if (text != passOneController.text) {
      return "Passwords do not match";
    }

    return null;
  }

  void _process() {
    if (formkey.currentState!.validate()) {
      context.read<AccountCubit>().register(
            nameController.text,
            emailController.text,
            passOneController.text,
            association,
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please try again.'),
          backgroundColor: const Color(0xFFFF6B6B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}