part of '../view/home_view.dart';

class _Card extends StatelessWidget {
  const _Card({
    required this.model,
    required this.onDeleteTap,
    required this.onEditTap,
    required this.onViewTap,
  });

  final FoodModel model;
  final VoidCallback onDeleteTap;
  final VoidCallback onEditTap;
  final VoidCallback onViewTap;

  final String deleteToolMessage = 'Sil';
  final String editToolMessage = 'Düzenle';
  final String viewToolMessage = 'Görüntüle';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: ListTile(
        onTap: onViewTap,
        shape: RoundedRectangleBorder(
          borderRadius: context.lowBorderRadius,
        ),
        contentPadding: context.paddingLow,
        tileColor: context.colorScheme.onPrimary,
        minLeadingWidth: context.width * .2,
        leading: buildImage(context),
        title: Text(model.title ?? ''),
        subtitle: Text(model.description ?? '', maxLines: 2),
        trailing: buildTrailing(context),
      ),
    );
  }

  Row buildTrailing(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconButton(
          iconData: Icons.visibility,
          color: context.colorScheme.primary,
          onTap: onViewTap,
          toolTip: viewToolMessage,
        ),
        CustomIconButton(
          iconData: Icons.edit,
          color: context.colorScheme.primary,
          onTap: onEditTap,
          toolTip: editToolMessage,
        ),
        CustomIconButton(
          iconData: Icons.delete,
          color: context.colorScheme.error,
          onTap: onDeleteTap,
          toolTip: deleteToolMessage,
        ),
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    return Padding(
      padding: context.paddingLow * .5,
      child: ClipRRect(
        borderRadius: context.lowBorderRadius,
        child: Image.network(
          model.imageUrl ?? '',
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
