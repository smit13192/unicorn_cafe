import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/address/bloc/address_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressBloc(),
      child: AddressView(),
    );
  }
}

class AddressView extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: const Column(
                children: [
                  _FullNameTextField(),
                  GapH(3.5),
                  _EmailTextField(),
                  GapH(3.5),
                  _MobileNumberTextField(),
                  GapH(3.5),
                  Row(
                    children: [
                      Expanded(child: _PincodeTextField()),
                      GapW(5),
                      Expanded(child: _CityTextField()),
                    ],
                  ),
                  GapH(3.5),
                  _StateTextField(),
                  GapH(3.5),
                  _AreaTextField(),
                  GapH(3.5),
                  _FlatTextField(),
                  GapH(3.5),
                  _AddressCheckBox(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: AppButton(
          text: 'Proceed to pay',
          onPressed: () {
            if (_key.currentState!.validate()) {
              context.read<AddressBloc>().add(SubmitEvent());
              Fluttertoast.showToast(
                msg: 'You go to the cafe and collect your order',
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.homeScreen,
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}

class _FullNameTextField extends StatelessWidget {
  const _FullNameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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

class _EmailTextField extends StatefulWidget {
  const _EmailTextField();

  @override
  State<_EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<_EmailTextField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    String email = context.read<FirebaseAuthService>().email;
    controller.text = email;
    context.read<AddressBloc>().add(EmailChangeEvent(email));
    super.initState();
  }

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
  const _MobileNumberTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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

class _PincodeTextField extends StatelessWidget {
  const _PincodeTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        context.read<AddressBloc>().add(PincodeChangeEvent(value));
      },
      validator: (value) {
        final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{6}$)');
        if (value == null || !regExp.hasMatch(value)) {
          return 'Enter pincode';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Pincode',
      ),
    );
  }
}

class _CityTextField extends StatelessWidget {
  const _CityTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        context.read<AddressBloc>().add(CityChangeEvent(value));
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter city';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'City',
      ),
    );
  }
}

class _StateTextField extends StatelessWidget {
  const _StateTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        context.read<AddressBloc>().add(StateChangeEvent(value));
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter state';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'State',
      ),
    );
  }
}

class _AreaTextField extends StatelessWidget {
  const _AreaTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        context.read<AddressBloc>().add(AreaChangeEvent(value));
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter area';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Locality / Area / Street',
      ),
    );
  }
}

class _FlatTextField extends StatelessWidget {
  const _FlatTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        context.read<AddressBloc>().add(FlatNameChangeEvent(value));
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter flat number/Building Name';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Flat no / Building Name',
      ),
    );
  }
}

class _AddressCheckBox extends StatelessWidget {
  const _AddressCheckBox();

  @override
  Widget build(BuildContext context) {
    bool save = context.select((AddressBloc value) => value.state.save);
    return Transform.translate(
      offset: const Offset(-10, 0),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: save,
              onChanged: (value) {
                context.read<AddressBloc>().add(AddressSaveChangeEvent(value!));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Text(
            'Mark as default address',
            style: TextStyle(
              fontSize: 15,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
