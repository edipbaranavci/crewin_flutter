import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/components/app_bar/general_app_bar.dart';
import '../../../../core/components/button/custom_elevated_text_button.dart';
import '../../../../core/components/button/custom_icon_button.dart';
import '../../../../core/components/text_field/general_text_form_field.dart';
import '../../../../core/extensions/context/save_user_model_context_extension.dart';
import '../../../../core/extensions/string/form_string_extension.dart';
import '../cubit/edit_food_cubit.dart';

class EditFoodView extends StatelessWidget {
  const EditFoodView({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditFoodCubit>(
      create: (context) => EditFoodCubit(context.getSaveUserModel, docId),
      child: const _EditFoodView(),
    );
  }
}

class _EditFoodView extends StatelessWidget {
  const _EditFoodView({Key? key}) : super(key: key);

  final String pageTitle = 'Yemek Tarifini Düzenle';

  final String foodTitleLabel = 'Yemeğin İsmi';
  final String foodMaterialsLabel = 'Malzemeler';
  final String foodDescriptionLabel = 'Tarifi';
  final String cancelButtonTitle = 'İptal';
  final String saveButtonTitle = 'Kaydet';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditFoodCubit>();
    return Scaffold(
      key: cubit.scaffoldKey,
      appBar: GeneralAppBar(pageTitle: pageTitle),
      body: SingleChildScrollView(
        padding: context.horizontalPaddingLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTextFormFieldsColumn(context),
            buildImage(),
            buildBottomButtons(context)
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return BlocBuilder<EditFoodCubit, EditFoodState>(
      builder: (context, state) {
        final cubit = context.read<EditFoodCubit>();
        final file = state.file;
        final imageUrl = state.imageUrl;
        if (file is File) {
          return InkWell(
            borderRadius: context.lowBorderRadius,
            onTap: () async => await cubit.pickImage(),
            child: Padding(
              padding: context.paddingLow * .5,
              child: ClipRRect(
                borderRadius: context.lowBorderRadius,
                child: Image.file(file),
              ),
            ),
          );
        } else if (imageUrl is String) {
          return InkWell(
            borderRadius: context.lowBorderRadius,
            onTap: () async => await cubit.pickImage(),
            child: Padding(
              padding: context.paddingLow * .5,
              child: ClipRRect(
                borderRadius: context.lowBorderRadius,
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return CustomIconButton(
                      iconData: Icons.camera_alt,
                      color: context.colorScheme.primary,
                      onTap: () async => await cubit.pickImage(),
                      size: context.width * .35,
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return CustomIconButton(
            iconData: Icons.camera_alt,
            color: context.colorScheme.primary,
            onTap: () async => await cubit.pickImage(),
            size: context.width * .35,
          );
        }
      },
    );
  }

  Row buildBottomButtons(BuildContext context) {
    final cubit = context.read<EditFoodCubit>();
    return Row(
      children: [
        Expanded(
          child: CustomElevatedTextButton(
            onPressed: () => context.pop(),
            title: cancelButtonTitle,
          ),
        ),
        context.emptySizedWidthBoxLow3x,
        BlocListener<EditFoodCubit, EditFoodState>(
          listener: (context, state) {
            if (state.isUpdated) {
              context.pop();
            }
          },
          child: Expanded(
            child: CustomElevatedTextButton(
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.updateFood();
                }
              },
              title: saveButtonTitle,
            ),
          ),
        ),
      ],
    );
  }

  Form buildTextFormFieldsColumn(BuildContext context) {
    final cubit = context.read<EditFoodCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          context.emptySizedHeightBoxLow,
          GeneralTextFormField(
            controller: cubit.foodTitle,
            labelText: foodTitleLabel,
            validator: (value) => value.defaultEmptyValidator,
          ),
          context.emptySizedHeightBoxLow3x,
          GeneralTextFormField(
            controller: cubit.foodMaterials,
            labelText: foodMaterialsLabel,
            maxLines: 3,
            validator: (value) => value.defaultEmptyValidator,
          ),
          context.emptySizedHeightBoxLow3x,
          GeneralTextFormField(
            controller: cubit.foodDescription,
            labelText: foodDescriptionLabel,
            maxLines: 10,
            validator: (value) => value.defaultEmptyValidator,
          ),
          context.emptySizedHeightBoxLow3x,
        ],
      ),
    );
  }
}
