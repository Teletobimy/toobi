import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/screens/group_screen/group_screens/chat_screen/add_image/add_image.dart';
import 'package:test01/screens/group_screen/group_screens/chat_screen/config/palette.dart';
import 'package:test01/screens/main_screen.dart';
import 'package:test01/screens/setting/colors.dart';
import 'package:animations/animations.dart';

class LoginSingUpScreen extends StatefulWidget {
  const LoginSingUpScreen({super.key});

  @override
  State<LoginSingUpScreen> createState() => _LoginSingUpScreenState();
}

class _LoginSingUpScreenState extends State<LoginSingUpScreen> {
  final _authentication = FirebaseAuth.instance;

  bool isSignupScreen = false;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();

  String userName = "";
  String userEmail = "";
  String userPassword = "";
  File? userPickedImage;

  var opacityValue = 0.0;

  void pickedImage(File image) {
    userPickedImage = image;
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: AddImage(pickedImage),
          );
        });
  }

  bool startScreen = true;
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  void initState() {
    super.initState();
    startScreen = false;
  }

  @override
  Widget build(BuildContext context) {
    return !startScreen
        ? Scaffold(
            body: GestureDetector(
              onTap: () async {
                setState(() {
                  opacityValue = 1.0;
                });
                Future.delayed(Duration(milliseconds: 5500), () {
                  setState(() {
                    startScreen = true;
                  });
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                      'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA5MjFfOTMg%2FMDAxNjk1Mjc4ODU5Mjkx.25Kr8wWoD5u0WZmew7FzggJ0E20PFBlWu4S7KPZVXfog.E-EjIeyaBZgtRroF0KTc6a9ihnvYKvTVJ_lrAlukBE8g.JPEG.lovelhn2121%2FScreenshot%25A3%25DF20230921%25A3%25DF152127%25A3%25DFSamsung_Internet.jpg&type=a340',
                    ),
                    // AssetImage(
                    //   'assets/startImage.jpg',
                    // ),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                    ),
                    AnimatedOpacity(
                      opacity: opacityValue,
                      duration: Duration(seconds: 4),
                      child: Text(
                        "📚독서 한잔, 커피 한잔☕",
                        style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Palette.backgroundColor,
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      decoration: const BoxDecoration(color: PRIMATY_COLOR
                          // image: DecorationImage(
                          //   image: AssetImage("assets/talk2.jpg"),
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                    ),
                    //전체 하얀 포지션 옮기기
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      top: 220,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        padding: const EdgeInsets.all(
                          20,
                        ),
                        height: isSignupScreen ? 360.0 : 230.0,
                        width: MediaQuery.of(context).size.width - 40,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSignupScreen = false;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          "로그인",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: !isSignupScreen
                                                ? Palette.activeColor
                                                : Palette.textColor1,
                                          ),
                                        ),
                                        if (!isSignupScreen)
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 3),
                                            height: 2,
                                            width: 55,
                                            color: Colors.orange,
                                          ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSignupScreen = true;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "회원가입",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: !isSignupScreen
                                                    ? Palette.textColor1
                                                    : Palette.activeColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            if (isSignupScreen)
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 3, 35, 0),
                                                height: 2,
                                                width: 55,
                                                color: Colors.orange,
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              //입력필드 시작~
                              if (isSignupScreen)
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () => showAlert(context),
                                            child: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/empty_person.jpg'))
                                            // AssetImage('assets/empty_person.jpg')

                                            // Container(
                                            //   //이미지 추가 기능
                                            //   width: 80,
                                            //   height: 80,
                                            //   decoration: BoxDecoration(
                                            //       image: DecorationImage(
                                            //           image: AssetImage(
                                            //               'assets/empty_person.jpg'),
                                            //           fit: BoxFit.cover),
                                            //       borderRadius:
                                            //           BorderRadius.circular(50)),
                                            // ),
                                            ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          key: const ValueKey(1),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 2) {
                                              return "2글자 이상 입력해주세요";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            userName = value!;
                                          },
                                          onChanged: (value) {
                                            userName = value;
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.account_circle,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            hintText: "이름",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(
                                              10,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          key: const ValueKey(2),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !value.contains('@')) {
                                              return "이메일 형식으로 기입해주세요";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            userEmail = value!;
                                          },
                                          onChanged: (value) {
                                            userEmail = value;
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            hintText: "이메일",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(
                                              10,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          key: const ValueKey(3),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 6) {
                                              return "비밀번호는 최소 7자입니다.";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            userPassword = value!;
                                          },
                                          onChanged: (value) {
                                            userPassword = value;
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            hintText: "비밀번호(최소7자)",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              //로그인 textfield 2개
                              if (!isSignupScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          key: const ValueKey(4),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !value.contains('@')) {
                                              return "이메일 형식으로 넣어주세요";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            userEmail = value!;
                                          },
                                          onChanged: (value) {
                                            userEmail = value;
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            hintText: "이메일",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(
                                              10,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          key: const ValueKey(5),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 6) {
                                              return "비밀번호는 최소 7자리 입니다";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            userPassword = value!;
                                          },
                                          onChanged: (value) {
                                            userPassword = value;
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: Palette.iconColor,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Palette.textColor1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  35.0,
                                                ),
                                              ),
                                            ),
                                            hintText: "비밀번호(최소7자)",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1,
                                            ),
                                            contentPadding: EdgeInsets.all(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //전송버튼
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      top: isSignupScreen ? 540 : 405,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                showSpinner = true;
                              });

                              if (isSignupScreen) {
                                if (userPickedImage == null) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('프로필 사진을 넣어주세요'),
                                        backgroundColor: Colors.blue),
                                  );
                                  return;
                                }
                                _tryValidation();

                                try {
                                  final newUser = await _authentication
                                      .createUserWithEmailAndPassword(
                                    email: userEmail,
                                    password: userPassword,
                                  );
                                  final refImage = FirebaseStorage.instance
                                      .ref()
                                      .child('picked_image')
                                      .child('${newUser.user!.uid}.png');
                                  await refImage.putFile(userPickedImage!);
                                  final url = await refImage.getDownloadURL();

                                  await FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(newUser.user!.uid)
                                      .set({
                                    'userName': userName,
                                    'email': userEmail,
                                    'picked_image': url
                                  });

                                  if (newUser.user != null) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const MainScreen2();
                                        },
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (kDebugMode) {
                                    print(e);
                                  }
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('이메일과 비밀번호를 한번 더 체크해주세요'),
                                        backgroundColor: Colors.blue,
                                      ),
                                    );
                                  }
                                } finally {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              }
                              if (!isSignupScreen) {
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();

                                  try {
                                    UserCredential newUser =
                                        await _authentication
                                            .signInWithEmailAndPassword(
                                      email: userEmail,
                                      password: userPassword,
                                    );
                                    print(
                                        "성공적으로 로그인!!! : ${newUser.user!.uid}");
                                    if (mounted) {
                                      if (newUser.user != null &&
                                          newUser.user?.uid != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const MainScreen2();
                                            },
                                          ),
                                        );
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }
                                  } catch (e) {
                                    if (e is FirebaseAuthException) {
                                      if (e.code == 'user-not-found') {
                                        print('이메일이 일치하는 사용자가 없습니다.');
                                      } else if (e.code == 'wrong-password') {
                                        print('비밀번호가 일치하지 않습니다.');
                                      } else {
                                        print('로그인 오류: ${e.code}');
                                      }

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('이메일과 비밀번호를 한번 더 체크해주세요'),
                                          backgroundColor: Colors.blue,
                                        ),
                                      );
                                    }
                                  } finally {
                                    showSpinner = false;
                                  }
                                }
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.orange,
                                    Colors.red,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(
                                  50,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //웰컴 ~ 컨티뉴
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.all(50)),
                          RichText(
                            text: TextSpan(
                              text: "📚독서 한잔, 커피 한잔☕",
                              style: const TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                              // children: [
                              //   TextSpan(
                              //     text: isSignupScreen
                              //         ? " to 📚독서 한잔, 커피 한잔☕"
                              //         : " to 📚독서 한잔, 커피 한잔☕",
                              //     style: const TextStyle(
                              //       letterSpacing: 1.0,
                              //       fontSize: 25,
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ],
                            ),
                          ),
                          Text(
                            isSignupScreen ? "       " : "       ",
                            style: const TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    //구글 추가 싸인업

                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      top: isSignupScreen
                          ? MediaQuery.of(context).size.height - 175
                          : MediaQuery.of(context).size.height - 185,
                      right: 0,
                      left: 0,
                      child: Column(
                        children: [
                          Text(
                            isSignupScreen
                                ? "or 구글로 로그인(개발중)"
                                : "or 구글로 회원가입(개발중)",
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              minimumSize: const Size(155, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Palette.googleColor,
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text("Google"),
                          ),
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
