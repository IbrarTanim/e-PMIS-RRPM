import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../../../data/models/all_projects_list_response.dart';
import '../../../../utils/common_widget.dart';
import '../../../../utils/date_util.dart';
import '../../root/root_controller.dart';
import 'add_pcr_controller.dart';

class AddPcrEvidenceScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const AddPcrEvidenceScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  State<AddPcrEvidenceScreen> createState() => _AddPcrEvidenceScreenState();
}

class _AddPcrEvidenceScreenState extends State<AddPcrEvidenceScreen> {
  final _controller = Get.put(AddPCRController());
  final _rootController = Get.put(RootController());

  XFile? _image;
  final now = DateTime.now();

  // DateTime? imageShootingDate =DateTime.now();
  // DateTime? imageShootingTime=DateTime.now();

  @override
  void dispose() {
    _controller.clearView();
    _controller.clearInputData();
    _image == null;
    // hideKeyboard(context);
    super.dispose();
  }

  @override
  void initState() {
    _controller.clearInputData();
    super.initState();
  }

  getImageFromCamera() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }

    setState(() {
      _image = image;
      _controller.imageShootingDate = formatDateToDDMMYYYY(now.toString());
      _controller.imageShootingTime = formatDateToHHMMAPM(now.toString());
    });
    print(_image);
  }

  getImageFromGallery() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBackAndUpload(
          title: 'UploadPCREvidence'.tr,
          iconPath: _image == null ? "" : AssetConstants.icUpload,
          onPress: _image == null
              ? () {}
              : () {
                  if (_controller.remarksEditController.value.text
                      .toString()
                      .isEmpty) {
                    showToast('Please write a remarks text.');
                  } else if (_controller.dateTextEditController.value.text
                      .toString()
                      .isEmpty) {
                    showToast('Please select PCR received date.');
                  } else {
                    _controller.uploadPcrImageFile(
                      context: context,
                      projectId:
                          widget.allProjectsResponse!.projectId.toString(),
                      imageFile: File(_image!.path),
                      remarks: stringNullCheck(_controller
                          .remarksEditController.value.text
                          .toString()),
                      receivedDate: stringNullCheck(_controller
                          .dateTextEditController.value.text
                          .toString()),
                    );
                    // Get.back();
                    Navigator.pop(context);
                  }

                  // showToast('PCR Evidence Uploaded Successfully');
                }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.all(16.0),
            child: _image == null
                ? Container(
                    alignment: Alignment.center,
                    child: textAutoSize(
                        text: "capture_image_message".tr,
                        alignment: Alignment.center),
                  )
                : Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalSheetFullScreenForGallery(context,
                              item: _image!.path.toString());
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.0),
                            child: SizedBox(
                                height: Get.height / 2,
                                child: Image.file(File(_image!.path)))),
                      ),
                      const SizedBox(height: 20),
/*                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "CapturedBy".tr,
                          rightText:
                              "${stringNullCheck(_rootController.userInfo.value.firstName)} ${stringNullCheck(_rootController.userInfo.value.lastName)}"),
                      // rightText: stringNullCheck(_image!.name.toString())),*/
                      const Divider(),
                      /*twoSidedTextWithColon2(
                          leftText: "PCRImageShootingDateAndTime".tr,
                          rightText:
                              "${stringNullCheck(_controller.imageShootingDate.toString())}, ${stringNullCheck(_controller.imageShootingTime.toString())}"),
                      const Divider(),*/
                      twoSidedTextWithDateField(context,
                          leftText: "PCRReceivedDate".tr,
                          textEditingController:
                              _controller.dateTextEditController),
                      const Divider(),
                      twoSidedTextWithTextField(
                          leftText: "Remarks".tr,
                          controller: _controller.remarksEditController),
                      // twoSidedTextWithDateField(
                      //     leftText: "PCRReceivedDate".tr,
                      //     controller: _controller.dateTextEditController),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     margin: const EdgeInsets.only(left: 32),
          //     child: FloatingActionButton.extended(
          //       icon: const Icon(Icons.image),
          //       onPressed: getImageFromGallery,
          //       label: const Text('Gallery'),
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              icon: const Icon(Icons.camera),
              onPressed: getImageFromCamera,
              label: const Text('Camera'),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getImage,
      //   child: const Icon(Icons.camera),
      // ),
    );
  }
}
