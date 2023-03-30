import 'dart:io';

import '../../../../core/components/button/custom_elevated_text_button.dart';
import '../../../../core/components/button/custom_icon_button.dart';
import '../../../../core/components/text_field/general_text_form_field.dart';
import '../../../../core/extensions/context/save_user_model_context_extension.dart';
import '../../../../core/extensions/string/form_string_extension.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/components/app_bar/custom_app_bar.dart';
import '../cubit/add_food_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFoodView extends StatelessWidget {
  const AddFoodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddFoodCubit>(
      create: (context) => AddFoodCubit(context.getSaveUserModel),
      child: const _AddFoodView(),
    );
  }
}

class _AddFoodView extends StatelessWidget {
  const _AddFoodView({Key? key}) : super(key: key);

  final String pageTitle = 'Yeni Yemek Tarifi';
  final String foodTitleLabel = 'Yemeğin İsmi';
  final String foodMaterialsLabel = 'Malzemeler';
  final String foodDescriptionLabel = 'Tarifi';
  final String cancelButtonTitle = 'İptal';
  final String saveButtonTitle = 'Kaydet';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddFoodCubit>();
    return Scaffold(
      key: cubit.scaffoldKey,
      appBar: CustomAppBar(pageTitle: pageTitle),
      body: SingleChildScrollView(
        padding: context.horizontalPaddingLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTextFormFieldsColumn(context),
            BlocBuilder<AddFoodCubit, AddFoodState>(
              builder: (context, state) {
                final file = state.file;
                if (file is File) {
                  return ClipRRect(
                    borderRadius: context.lowBorderRadius,
                    child: Image.file(file),
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
            ),
            buildBottomButtons(context)
          ],
        ),
      ),
    );
  }

  Row buildBottomButtons(BuildContext context) {
    final cubit = context.read<AddFoodCubit>();
    return Row(
      children: [
        Expanded(
          child: CustomElevatedTextButton(
            onPressed: () => context.pop(),
            title: cancelButtonTitle,
          ),
        ),
        context.emptySizedWidthBoxLow3x,
        BlocListener<AddFoodCubit, AddFoodState>(
          listener: (context, state) {
            if (state.isAdded) {
              context.pop();
            }
          },
          child: Expanded(
            child: CustomElevatedTextButton(
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.addFood();
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
    final cubit = context.read<AddFoodCubit>();
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
