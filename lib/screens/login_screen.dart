import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test01/screens/group_screen/group_screens/chat_screen/config/palette.dart';
import 'package:test01/screens/main_screen.dart';

class LoginSingUpScreen extends StatefulWidget {
  const LoginSingUpScreen({super.key});

  @override
  State<LoginSingUpScreen> createState() => _LoginSingUpScreenState();
}

class _LoginSingUpScreenState extends State<LoginSingUpScreen> {
  bool isSignupPage = false;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool imageCheck = false;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 700,
        maxHeight: 700,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        aspectRatioPresets: const [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 70,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );

      if (croppedFile != null) {
        _image = await convertCroppedFileToFile(croppedFile);
        imageCheck = true;
        setState(() {
          _image = _image;
        });
      }
    }
  }

  Future<File> convertCroppedFileToFile(CroppedFile croppedFile) async {
    final tempDir = await getTemporaryDirectory();
    final uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final File tempFile = File('${tempDir.path}/$uniqueFileName.jpg');

    // Get the cropped image file as bytes
    final croppedBytes = await croppedFile.readAsBytes();

    // Write the cropped image bytes to the new file
    await tempFile.writeAsBytes(croppedBytes);

    return tempFile;
  }

  String userName = "";
  String userEmail = "";
  String userPw = "";

  void pickImage(File image) {
    _image = image;
  }

  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _signUp(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        // 이미지를 Firebase Storage에 업로드
        Reference ref = _storage.ref().child('user_images/$uid.jpg');

        await ref.putFile(_image!);

        // 다운로드 URL 가져오기
        String imageURL = await ref.getDownloadURL();

        // 사용자 정보를 Firestore 또는 Realtime Database에 저장 (예: Firestore)
        // 여기에서는 예시로 Firestore를 사용하는 방법을 보여줍니다.
        // Firestore에 사용자 정보 저장
        await FirebaseFirestore.instance.collection('user').doc(uid).set({
          'email': _emailController.text,
          'userName': _nameController.text,
          'picked_image': imageURL,
        });

        // 회원가입 성공 시 작업 수행
        // 예: 다음 화면으로 이동
        if (context.mounted) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginedScreen()));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("$e"),
          backgroundColor: Colors.blue,
        ));
      }
      // 회원가입 실패 시 예외 처리
      // 예: 오류 메시지를 보여주거나 적절한 처리를 진행
    }
  }

  var opacityValue = 0.0;
  bool startScreen = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startScreen = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailLoginController.dispose();
    _passwordController.dispose();
    _passwordLoginController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;

    return !startScreen
        ? Scaffold(
            body: GestureDetector(
              onTap: () async {
                setState(() {
                  opacityValue = 1.0;
                });
                Future.delayed(Duration(milliseconds: 4000), () {
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
                      duration: Duration(seconds: 3),
                      child: Text(
                        "📚독서 한잔, 커피 한잔☕",
                        style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: sHeight / 1.5,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            opacityValue = 1.0;
                          });
                          Future.delayed(Duration(milliseconds: 4000), () {
                            setState(() {
                              startScreen = true;
                            });
                          });
                        },
                        child: Text(
                          "시작하기",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 92, 55, 177)),
                        ))
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  // 배경을 위한 컨테이너
                  SingleChildScrollView(
                    child: Container(
                      height: sHeight,
                      width: sWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(
                            'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA5MjFfOTMg%2FMDAxNjk1Mjc4ODU5Mjkx.25Kr8wWoD5u0WZmew7FzggJ0E20PFBlWu4S7KPZVXfog.E-EjIeyaBZgtRroF0KTc6a9ihnvYKvTVJ_lrAlukBE8g.JPEG.lovelhn2121%2FScreenshot%25A3%25DF20230921%25A3%25DF152127%25A3%25DFSamsung_Internet.jpg&type=a340',
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeIn,
                    top: isSignupPage
                        ? sHeight / 14 - bottomInsets / 3
                        : sHeight / 8 - bottomInsets / 3,
                    left: sWidth * 0.1,
                    height: isSignupPage ? sHeight * 0.83 : sHeight * 0.7,
                    child: Container(
                      width: sWidth * 0.8,
                      decoration: BoxDecoration(
                          color: isSignupPage
                              ? Colors.red.withOpacity(0.45)
                              : Colors.blue.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.amber),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5,
                            )
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: sHeight / 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isSignupPage = false;
                                    });
                                  },
                                  child: const Text("로그인")),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isSignupPage = true;
                                    });
                                  },
                                  child: const Text("회원가입")),
                            ],
                          ),
                          // 로그인 화면 단
                          if (!isSignupPage)
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const Text(
                                    "개발:아이디,비번 DB 연결하기",
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      key: const ValueKey(1),
                                      controller: _emailLoginController,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 3 ||
                                            !value.contains('@') ||
                                            !value.contains('.')) {
                                          return "이메일 형식으로 넣어주세요";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (newValue) {
                                        userEmail = newValue!;
                                      },
                                      onChanged: (value) {
                                        userEmail = value;
                                      },
                                      decoration: const InputDecoration(
                                        label: Text(
                                          "이메일 (3글자 이상)",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.account_box,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        contentPadding: EdgeInsets.all(10),
                                        helperText: "ex) abc@abc.com",
                                        helperStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      controller: _passwordLoginController,
                                      key: const ValueKey(2),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return "비밀번호 : 5글자 이상 입력해 주세요";
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        userPw = newValue!;
                                      },
                                      onChanged: (value) {
                                        userPw = value;
                                      },
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          "비밀번호 (6 글자 이상)",
                                        ),
                                        labelStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        prefixIcon: Icon(
                                          Icons.lock_open,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        contentPadding: EdgeInsets.all(10),
                                        helperText: "비밀번호 (6 글자 이상)",
                                        helperStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            await _auth
                                                .signInWithEmailAndPassword(
                                                    email: _emailLoginController
                                                        .text,
                                                    password:
                                                        _passwordLoginController
                                                            .text);

                                            if (context.mounted) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginedScreen()));
                                            }
                                          } catch (e) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text("아이디 비번을 확인해 주세요"),
                                                backgroundColor: Colors.blue,
                                              ));
                                            }
                                          }
                                        }
                                      },
                                      child: const Text(
                                        "로그인",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                  SizedBox(
                                    height: sHeight / 80,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const LoginedScreen();
                                            }));
                                          },
                                          child: const Text(
                                            "카카오로 로그인",
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const LoginedScreen();
                                            }));
                                          },
                                          child: const Text("네이버로 로그인")),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          // 회원가입 화면 단
                          else
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => _getImage(),
                                    child: SizedBox(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: _image != null
                                            ? FileImage(_image!)
                                            : null,
                                        child: _image == null
                                            ? const Icon(
                                                Icons.camera_alt,
                                                size: 25,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "프로필 사진 입력",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Palette.textColor1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: TextFormField(
                                      key: const ValueKey(3),
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 3 ||
                                            !value.contains('@') ||
                                            !value.contains('.')) {
                                          return "이메일 형식으로 입력해 주세요";
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        userEmail = newValue!;
                                      },
                                      onChanged: (value) {
                                        userEmail = value;
                                      },
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_box,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        helperText: "이메일 (3글자 이상)",
                                        helperStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: TextFormField(
                                      key: const ValueKey(4),
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return "비밀번호 : 6글자 이상 입력해 주세요";
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        userPw = newValue!;
                                      },
                                      obscureText: true,
                                      onChanged: (value) {
                                        userPw = value;
                                      },
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock_open,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        helperText: "비밀번호 (6글자 이상)",
                                        helperStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: TextFormField(
                                      key: const ValueKey(5),
                                      controller: _nameController,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 2) {
                                          return "이름 : 2글자 이상 입력해 주세요";
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        userPw = newValue!;
                                      },
                                      onChanged: (value) {
                                        userPw = value;
                                      },
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        helperText: "이름 (2글자 이상)",
                                        helperStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (!imageCheck) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("프사를 넣어주세요"),
                                            backgroundColor: Colors.blue,
                                          ));
                                        } else if (_formKey.currentState!
                                            .validate()) {
                                          _signUp(context);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("회원가입 실패"),
                                            backgroundColor: Colors.blue,
                                          ));
                                        }
                                      },
                                      child: const Text(
                                        "회원가입",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                  SizedBox(
                                    height: sHeight / 80,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const LoginedScreen();
                                            }));
                                          },
                                          child: const Text(
                                            "카카오로 로그인",
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const LoginedScreen();
                                            }));
                                          },
                                          child: const Text("네이버로 로그인")),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class AddImage extends StatefulWidget {
  const AddImage(this.addImageFunc, {Key? key}) : super(key: key);

  final Function(File pickedImage) addImageFunc;

  @override
  State<AddImage> createState() => _AddImageState();
}

// File file = getFile();

class _AddImageState extends State<AddImage> {
  File? pickedImage;
  Future _pickImage() async {
    final imagePicker = ImagePicker();
    // final LostDataResponse response = await imagePicker.retrieveLostData();

    var pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );
    if (pickedImageFile != null) {
      setState(() {
        // if (pickedImageFile != null) {
        //   pickedImage = File(pickedImageFile.path);
        // }
        // else {

        pickedImage = File(pickedImageFile.path);
        widget.addImageFunc(pickedImage!);
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: 150,
      height: 300,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage:
                pickedImage != null ? FileImage(pickedImage!) : null,
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
              onPressed: () {
                _pickImage();
              },
              icon: const Icon(Icons.image),
              label: const Text("프사 추가")),
          const SizedBox(
            height: 80,
          ),
          TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
              label: const Text('종료'))
        ],
      ),
    );
  }
}
