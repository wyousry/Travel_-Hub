import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_hub/features/ai_camera/service/api_service.dart';
import 'package:travel_hub/features/ai_camera/service/tts_service.dart';


class AiCamera extends StatefulWidget {
  const AiCamera({Key? key}) : super(key: key);

  @override
  State<AiCamera> createState() => _AiWikiPageState();
}

class _AiWikiPageState extends State<AiCamera> {
  File? _image;
  String? _title;
  String? _summaryEn;
  String? _summaryAr;
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pick(ImageSource src) async {
    try {
      final XFile? picked =
          await _picker.pickImage(source: src, imageQuality: 80);

      if (picked == null) return;

      setState(() {
        _image = File(picked.path);
        _loading = true;
        _title = null;
        _summaryAr = null;
        _summaryEn = null;
      });

      // 2. إرسال الصورة وانتظار الاستجابة
      final res = await ApiService.sendImage(_image!);

      setState(() {
        _loading = false;
      });

      // 3. التحقق من وجود خطأ (إذا كانت الاستجابة Map وفيها حقل 'error')
      if (res is Map && res.containsKey('error')) {
        _showError(res['error'].toString());
        return;
      }
      
      // 4. التحقق من هيكل الاستجابة (يجب أن تكون قائمة غير فارغة)
      if (res is! List || res.isEmpty) {
         _showError("هيكل الاستجابة غير صالح. تأكدي من أن الخادم يعمل بشكل صحيح.");
         return;
      }
      
      // 5. استخراج التنبؤ الأول والأعلى ثقة (prediction)
      final prediction = res.first as Map<String, dynamic>;

      // 6. تعيين البيانات في حالة الواجهة
      setState(() {
        _title = prediction['label'] ?? "Unknown";
        _summaryEn = prediction['wikipedia_en'] ?? "";
        _summaryAr = prediction['wikipedia_ar'] ?? "";
      });

      // يمكنك عرض رسالة تنبيه إذا لم يتم العثور على وصف
      if (_summaryAr!.isEmpty) {
        _showError("تم التعرّف على المكان: $_title، لكن لم يتم العثور على مقال في ويكيبيديا.");
      }

    } catch (e) {
      _showError("حدث خطأ غير متوقع: ${e.toString()}");
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('الكاميرا'),
                onTap: () {
                  Navigator.pop(context);
                  _pick(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('المعرض'),
                onTap: () {
                  Navigator.pop(context);
                  _pick(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    // تحديد اتجاه النص ليتناسب مع اللغة العربية (RTL)
    final isArabic = (_summaryAr ?? '').isNotEmpty;
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    
    return Scaffold(
      appBar: AppBar(title: const Text('📷 مستكشف ويكيبيديا الذكي')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPicker,
        child: const Icon(Icons.camera_alt),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // عرض الصورة المختارة
            if (_image != null)
              Image.file(
                _image!,
                height: 220,
                fit: BoxFit.cover,
              ),

            const SizedBox(height: 12),

            // عرض مؤشر التحميل
            if (_loading) const CircularProgressIndicator(),

            // عرض النتائج عند الانتهاء
            if (!_loading && _summaryAr != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // عنوان المكان المتوقع
                      if (_title != null)
                        Text(
                          _title!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: textDirection,
                        ),

                      const SizedBox(height: 12),

                      // الترجمة العربية
                      if (_summaryAr != null && _summaryAr!.isNotEmpty)
                        Text(
                          '📗 الملخص بالعربية:\n' + _summaryAr!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        )
                      else if (_title != null)
                        Text(
                           "❌ لم يتم العثور على وصف باللغة العربية لـ: $_title",
                           style: const TextStyle(color: Colors.redAccent),
                           textDirection: TextDirection.rtl,
                        ),
                      
                      const SizedBox(height: 12),

                      // النص الإنجليزي الأصلي
                      if (_summaryEn != null && _summaryEn!.isNotEmpty)
                        Text(
                          '📘 Wikipedia (English):\n' + _summaryEn!,
                          style: TextStyle(color: Colors.grey[700]),
                          textDirection: TextDirection.ltr,
                        ),

                      const SizedBox(height: 12),

                      // زر القراءة الصوتية
                      if (_summaryAr != null && _summaryAr!.isNotEmpty)
                        ElevatedButton.icon(
                          onPressed: () =>
                              // يتكلم بالعربية إذا وجدت وإلا يستخدم الإنجليزية
                              TtsService.speak(_summaryAr!), 
                          icon: const Icon(Icons.volume_up),
                          label: const Text('استمع إلى الملخص'),
                        ),
                    ],
                  ),
                ),
              ),

            // رسالة البداية
            if (!_loading && _image == null)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'اضغطي زر الكاميرا لاختيار صورة وبدء التعرف عليها.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}