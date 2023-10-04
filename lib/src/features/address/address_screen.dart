import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/screen_loading_controller.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/utils/either_result.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/address/bloc/address_bloc.dart';
import 'package:unicorn_cafe/src/model/cart_model.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class AddressScreen extends StatelessWidget {
  final List<CartModel> orders;
  const AddressScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressBloc(
        firebaseAuthService: context.read<FirebaseAuthService>(),
        firebaseCloudService: context.read<FirebaseCloudService>(),
      ),
      child: _AddressView(orders),
    );
  }
}

class _AddressView extends StatefulWidget {
  final List<CartModel> orders;
  @override
  const _AddressView(this.orders);

  @override
  State<_AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<_AddressView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  void getAddress() async {
    String uid = context.read<FirebaseAuthService>().uid;
    EitherResult<Map<String, dynamic>> result =
        await context.read<FirebaseCloudService>().getUserAddress(uid);
    result.fold(
      (l) {
        emailController.text = context.read<FirebaseAuthService>().email;
        context
            .read<AddressBloc>()
            .add(EmailChangeEvent(context.read<FirebaseAuthService>().email));
      },
      (r) {
        mobileNoController.text = r['mobileNo'];
        emailController.text = r['email'];
        usernameController.text = r['username'];
        context.read<AddressBloc>().add(
              GetDefaultEvent(
                username: r['username'],
                email: r['email'],
                mobileNo: r['mobileNo'],
              ),
            );
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          ScreenLoadingController.instance.hide();
          ScreenLoadingController.instance.show(context);
        } else {
          ScreenLoadingController.instance.hide();
        }
        if (state.status.isFailed) {
          Fluttertoast.showToast(msg: state.error);
        } else if (state.status.isSuccess) {
          Fluttertoast.showToast(
            msg: 'You go to the cafe and collect your order',
          );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add Address',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.primaryColor,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.5.w),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    _FullNameTextField(usernameController),
                    const GapH(3.5),
                    _EmailTextField(emailController),
                    const GapH(3.5),
                    _MobileNumberTextField(mobileNoController),
                    const GapH(3.5),
                    AppButton(
                      text: 'Confirm Your Order',
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          context
                              .read<AddressBloc>()
                              .add(SubmitEvent(widget.orders));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullNameTextField extends StatelessWidget {
  final TextEditingController controller;
  const _FullNameTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        context.read<AddressBloc>().add(UsernameChangeEvent(value));
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter valid username';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter Username',
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  const _EmailTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        context.read<AddressBloc>().add(EmailChangeEvent(value));
      },
      validator: (value) {
        final regExp = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        );
        if (value == null || !regExp.hasMatch(value)) {
          return 'Enter valid email';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter Email',
      ),
    );
  }
}

class _MobileNumberTextField extends StatelessWidget {
  final TextEditingController controller;
  const _MobileNumberTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        context.read<AddressBloc>().add(MobileNoChangeEvent(value));
      },
      validator: (value) {
        final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
        if (value == null || !regExp.hasMatch(value)) {
          return 'Enter valid phone no';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter Mobile Number',
      ),
    );
  }
}
