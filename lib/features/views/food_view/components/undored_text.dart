part of '../view/food_view_view.dart';

class _UnorderedText extends StatelessWidget {
  const _UnorderedText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("• ", style: context.textTheme.titleMedium),
        Expanded(child: Text(text)),
      ],
    );
  }
}
