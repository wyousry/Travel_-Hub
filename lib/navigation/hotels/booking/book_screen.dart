import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/hotels/presentation/widgets/custom_button.dart';
import 'package:travel_hub/navigation/hotels/presentation/widgets/custom_field.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController destination = TextEditingController();
  final TextEditingController checkIn = TextEditingController();
  final TextEditingController checkOut = TextEditingController();
  final TextEditingController guests = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      String formDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        controller.text = formDate;
      });
    }
  }

  late DateTime selectedDate;
  late DateTime today;
  late DateTime todayDate;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    todayDate = DateTime(today.year, today.month, today.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Book Your Trip",
              style: TextStyle(color: Colors.white, fontSize: 24.sp),
            ),
            Text(
              "Complete your reservation",
              style: TextStyle(color: Color(0xffDBEAFE), fontSize: 16.sp),
            ),
          ],
        ),
      ),
      backgroundColor: kWhite,
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.r),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomField(
                title: "Destination",
                width: double.infinity,
                controller: destination,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter city or hotel name";
                  }
                  return null;
                },
                hint: "Enter city or hotel name",
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomField(
                      title: "Check-in",
                      width: double.infinity,
                      controller: checkIn,
                      keyboard: TextInputType.datetime,
                      onTap: () {
                        return selectDate(context, checkIn);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a check in date";
                        }
                        try {
                          selectedDate = DateFormat(
                            'dd/MM/yyyy',
                          ).parseStrict(value);
                          if (selectedDate.isBefore(todayDate)) {
                            return "check in date can't be before today";
                          }
                        } catch (e) {
                          return "The date format is incorrect";
                        }
                        return null;
                      },
                      icon: Icons.calendar_today,
                      hint: "DD/MM/YYYY",
                    ),
                  ),
                  Expanded(
                    child: CustomField(
                      title: "Check-out",
                      width: double.infinity,
                      controller: checkOut,
                      keyboard: TextInputType.datetime,
                      onTap: () {
                        return selectDate(context, checkOut);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a check out date";
                        }
                        try {
                          selectedDate = DateFormat(
                            'dd/MM/yyyy',
                          ).parseStrict(value);
                          if (selectedDate.isBefore(todayDate)) {
                            return "check out date can't be before today";
                          }
                        } catch (e) {
                          return "The date format is incorrect";
                        }
                        return null;
                      },
                      icon: Icons.calendar_today,
                      hint: "DD/MM/YYYY",
                    ),
                  ),
                ],
              ),
              CustomField(
                title: "Guests",
                width: double.infinity,
                controller: guests,
                keyboard: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the number of guests";
                  }
                  return null;
                },
                icon: Icons.people_alt_outlined 
                ,
              ),
              Divider(color: Color(0xffF3F3F5), thickness: 2.h),
              Text(
                "Contact Information",
                style: TextStyle(color: kBlack, fontSize: 18.sp),
              ),
              SizedBox(height: 12.h),
              CustomField(
                title: "Full Name",
                width: double.infinity,
                controller: fullName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your full name";
                  }
                  return null;
                },
                hint: "Enter your full name",
              ),
              CustomField(
                title: "Email",
                width: double.infinity,
                controller: email,
                keyboard: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!value.contains("@")) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
                hint: "Enter your email",
              ),
              CustomField(
                title: "Phone Number",
                width: double.infinity,
                controller: phoneNumber,
                keyboard: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  } else if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
                    return 'please enter a valid Egyptian phone number';
                  }
                  return null;
                },
                hint: "Enter your phone number",
              ),
              CustomButton(
                buttonText: "Complete Booking",
                icon: Icons.payment,
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
