import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crewin_flutter/core/components/button/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../core/components/app_bar/general_app_bar.dart';
import '../../../../core/components/button/custom_elevated_text_button.dart';
import '../../../../core/extensions/context/save_user_model_context_extension.dart';
import '../../../../cubit/main_cubit.dart';
import '../../../models/food/food_model.dart';
import '../../add_food/view/add_food_view.dart';
import '../cubit/home_cubit.dart';

part '../components/card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(context.getSaveUserModel),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  final String fabTitle = 'Yeni Tarif Ekle';
  final String pageTitle = 'Yemek Tariflerim';
  final String errorBuilderTitle = 'Sunucuda Hata Var!';

  final String emptyCardMessage = 'Henüz Bir Tarif Eklemediniz!';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Scaffold(
      key: cubit.scaffoldKey,
      appBar: GeneralAppBar(pageTitle: pageTitle),
      floatingActionButton: CustomElevatedTextButton(
        onPressed: () => context.navigateToPage(const AddFoodView()),
        title: fabTitle,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.stream != null) {
            return StreamBuilder<QuerySnapshot>(
              stream: state.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(errorBuilderTitle);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildLoadingIndicator();
                }
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return buildEmptyCard(context);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data()! as Map<String, dynamic>;
                    return _Card(
                      model: FoodModel.fromJson(data),
                      onDeleteTap: () => cubit.deleteRecipe(docs[index].id),
                      onEditTap: () {},
                      onViewTap: () {},
                    );
                  },
                );
              },
            );
          } else {
            return buildLoadingIndicator();
          }
        },
      ),
    );
  }

  Center buildEmptyCard(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_late_rounded,
            color: context.colorScheme.primary,
            size: context.highValue,
          ),
          context.emptySizedHeightBoxLow3x,
          Text(
            emptyCardMessage,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Center buildLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());
}
