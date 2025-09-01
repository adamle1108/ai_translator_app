import 'package:aivoicetranslation/widgets/textfield.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../Model/DicionaryModel.dart';
import 'DictionaryController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DictionaryView extends GetView<DictionaryController> {
  const DictionaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.hintColor,
        title: Text(
          "Dictionary",
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<DictionaryController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: context.theme.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: AppTextField(
                  hintText: tr("Enter Text"),
                  controller: controller.textController,
                  maxLines: 1,
                  onTap: () {

                  },
                  suffixIcon: IconButton(
                      onPressed: () async {
                        await controller.fetchMeaning(controller.textController.text);
                      },
                      icon: Icon(
                        Icons.search,
                        color: context.theme.primaryColor,
                      )),
                )),
                const SizedBox(height: 12),
                if (controller.inProgress)
                  Center(
                      child: LinearProgressIndicator(
                    color: context.theme.focusColor,
                  ))
                else if (controller.responseModel != null)
                  Expanded(child: _buildResponseWidget(context))
                else
                  _noDataWidget(context),
              ],
            );
          },
        ),
      ),
    ));
  }

  _buildResponseWidget(BuildContext context) {
    return GetBuilder<DictionaryController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                controller.responseModel!.word!,
                style: context.textTheme.headlineMedium,
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return _buildMeaningWidget(
                    controller.responseModel!.meanings![index], context);
              },
              itemCount: controller.responseModel!.meanings!.length,
            ))
          ],
        );
      },
    );
  }

  _buildMeaningWidget(Meanings meanings, BuildContext context) {
    String definitionList = "";
    meanings.definitions?.forEach(
      (element) {
        int index = meanings.definitions!.indexOf(element);
        definitionList += "\n${index + 1}. ${element.definition}\n";
      },
    );

    return Card(
      color: context.theme.hintColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meanings.partOfSpeech!,
              style: TextStyle(
                color: context.theme.focusColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Definitions : ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              definitionList,
              style: context.textTheme.titleSmall,
            ),
            _buildSet("Synonyms", meanings.synonyms, context),
            _buildSet("Antonyms", meanings.antonyms, context),
          ],
        ),
      ),
    );
  }

  _buildSet(String title, List<String>? setList, BuildContext context) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            setList!.toSet().toString().replaceAll("{", "").replaceAll("}", ""),
            style: context.textTheme.titleSmall,
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _noDataWidget(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Center(
        child: Text(
          controller.noDataText,
          style: const TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }
}

// return SearchBar(
// backgroundColor: Colors.white,
// hintText: "Search word here",
// onSubmitted: (value) async {
// await controller.fetchMeaning(value);
// },
// );
