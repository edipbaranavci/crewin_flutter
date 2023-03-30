import 'package:crewin_flutter/core/components/app_bar/custom_app_bar.dart';
import 'package:crewin_flutter/core/components/app_bar/general_app_bar.dart';
import 'package:crewin_flutter/core/components/button/custom_icon_button.dart';
import 'package:crewin_flutter/core/extensions/context/save_user_model_context_extension.dart';
import 'package:crewin_flutter/core/init/navigation/enums/router_enums.dart';
import 'package:crewin_flutter/core/init/navigation/router/router_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../models/food/food_model.dart';
import '../cubit/food_view_cubit.dart';

part '../components/undored_text.dart';

class FoodViewView extends StatelessWidget {
  const FoodViewView({Key? key, required this.foodModel, required this.docId})
      : super(key: key);
  final FoodModel foodModel;
  final String docId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodViewCubit>(
      create: (context) => FoodViewCubit(context.getSaveUserModel, docId),
      child: _FoodViewView(foodModel: foodModel),
    );
  }
}

class _FoodViewView extends StatelessWidget {
  final FoodModel foodModel;
  const _FoodViewView({Key? key, required this.foodModel}) : super(key: key);

  final String materialsTitle = 'Gerekli Malzemeler:';
  final String recipeTitle = 'Tarif:';
  final String deleteToolMessage = 'Sil';
  final String editToolMessage = 'Düzenle';

  @override
  Widget build(BuildContext context) {
    final result = foodModel.materials?.split('\n');
    return Scaffold(
      key: context.read<FoodViewCubit>().scaffoldKey,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        padding: context.horizontalPaddingLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            context.emptySizedHeightBoxLow,
            buildTitleItem(context, materialsTitle),
            context.emptySizedHeightBoxLow,
            buildMaterialsText(context, result),
            context.emptySizedHeightBoxLow3x,
            buildTitleItem(context, recipeTitle),
            context.emptySizedHeightBoxLow,
            buildDescription(context),
            context.emptySizedHeightBoxLow3x,
            foodModel.imageUrl is String
                ? buildImage(context)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  GeneralAppBar buildAppBar(BuildContext context) {
    return GeneralAppBar(pageTitle: foodModel.title ?? '', actions: [
      Center(
        child: CustomIconButton(
          iconData: Icons.edit,
          color: context.colorScheme.primary,
          onTap: () {},
          toolTip: editToolMessage,
        ),
      ),
      Center(
        child: BlocListener<FoodViewCubit, FoodViewState>(
          listener: (context, state) {
            if (state.isDeleted) {
              context.pop();
            }
          },
          child: CustomIconButton(
            iconData: Icons.delete,
            color: context.colorScheme.error,
            onTap: () => context.read<FoodViewCubit>().deleteRecipe(),
            toolTip: deleteToolMessage,
          ),
        ),
      ),
    ]);
  }

  Padding buildDescription(BuildContext context) {
    return Padding(
      padding: context.onlyLeftPaddingLow,
      child: Text(
        foodModel.description ?? '',
        style: context.textTheme.titleMedium,
      ),
    );
  }

  ListView buildMaterialsText(BuildContext context, List<String>? result) {
    return ListView.builder(
      padding: context.onlyLeftPaddingLow,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: result?.length ?? 0,
      itemBuilder: (context, index) => _UnorderedText(result?[index] ?? ''),
    );
  }

  Text buildTitleItem(BuildContext context, String title) {
    return Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return Padding(
      padding: context.paddingLow * .5,
      child: ClipRRect(
        borderRadius: context.lowBorderRadius,
        child: Image.network(
          foodModel.imageUrl ?? '',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.image_not_supported_outlined,
              size: context.highValue * .5,
            );
          },
        ),
      ),
    );
  }
}
