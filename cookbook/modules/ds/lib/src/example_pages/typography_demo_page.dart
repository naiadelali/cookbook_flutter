import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

class TypographyDemoPage extends StatelessWidget {
  const TypographyDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizing.x12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypographySection('Display Normal (Inter)', [
              _buildTypographyItem(
                  'Display Normal Large', AppTypography.displayNormalLarge),
              _buildTypographyItem(
                  'Display Normal Medium', AppTypography.displayNormalMedium),
              _buildTypographyItem(
                  'Display Normal Small', AppTypography.displayNormalSmall),
            ]),
            _buildTypographySection('Display Thin (Inter)', [
              _buildTypographyItem(
                  'Display Thin Large', AppTypography.displayThinLarge),
              _buildTypographyItem(
                  'Display Thin Medium', AppTypography.displayThinMedium),
              _buildTypographyItem(
                  'Display Thin Small', AppTypography.displayThinSmall),
            ]),
            _buildTypographySection('Title Normal (Inter)', [
              _buildTypographyItem(
                  'Title Normal Large', AppTypography.titleNormalLarge),
              _buildTypographyItem(
                  'Title Normal Medium', AppTypography.titleNormalMedium),
              _buildTypographyItem(
                  'Title Normal Small', AppTypography.titleNormalSmall),
            ]),
            _buildTypographySection('Title Thin (Inter)', [
              _buildTypographyItem(
                  'Title Thin Large', AppTypography.titleThinLarge),
              _buildTypographyItem(
                  'Title Thin Medium', AppTypography.titleThinMedium),
              _buildTypographyItem(
                  'Title Thin Small', AppTypography.titleThinSmall),
            ]),
            _buildTypographySection('Subtitle Normal (Inter)', [
              _buildTypographyItem(
                  'Subtitle Normal Large', AppTypography.subtitleNormalLarge),
              _buildTypographyItem(
                  'Subtitle Normal Medium', AppTypography.subtitleNormalMedium),
              _buildTypographyItem(
                  'Subtitle Normal Small', AppTypography.subtitleNormalSmall),
            ]),
            _buildTypographySection('Subtitle Thin (Inter)', [
              _buildTypographyItem(
                  'Subtitle Thin Large', AppTypography.subtitleThinLarge),
              _buildTypographyItem(
                  'Subtitle Thin Medium', AppTypography.subtitleThinMedium),
              _buildTypographyItem(
                  'Subtitle Thin Small', AppTypography.subtitleThinSmall),
            ]),
            _buildTypographySection('Body Normal (Inter)', [
              _buildTypographyItem(
                  'Body Normal Large', AppTypography.bodyNormalLarge),
              _buildTypographyItem(
                  'Body Normal Medium', AppTypography.bodyNormalMedium),
              _buildTypographyItem(
                  'Body Normal Small', AppTypography.bodyNormalSmall),
            ]),
            _buildTypographySection('Label Normal (Inter)', [
              _buildTypographyItem(
                  'Label Normal Large', AppTypography.labelNormalLarge),
              _buildTypographyItem(
                  'Label Normal Medium', AppTypography.labelNormalMedium),
              _buildTypographyItem(
                  'Label Normal Small', AppTypography.labelNormalSmall),
              _buildTypographyItem(
                  'Label Normal Nano', AppTypography.labelNormalNano),
            ]),
            _buildTypographySection('Label Thin (Inter)', [
              _buildTypographyItem(
                  'Label Thin Large', AppTypography.labelThinLarge),
              _buildTypographyItem(
                  'Label Thin Medium', AppTypography.labelThinMedium),
              _buildTypographyItem(
                  'Label Thin Small', AppTypography.labelThinSmall),
              _buildTypographyItem(
                  'Label Thin Nano', AppTypography.labelThinNano),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographySection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.displayNormalSmall.copyWith(
            color: AppColor.primary.main,
          ),
        ),
        SizedBox(height: AppSizing.x12),
        ...items,
      ],
    );
  }

  Widget _buildTypographyItem(String label, TextStyle style) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizing.x12),
      padding: EdgeInsets.all(AppSizing.x12),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.neutral.soft),
        borderRadius: BorderRadius.circular(AppSizing.x8),
        color: AppColor.surface.defaults,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: style.copyWith(
              color: AppColor.secondary.main,
            ),
          ),
          SizedBox(height: AppSizing.x4),
          _buildTypographyDetails(style),
        ],
      ),
    );
  }

  Widget _buildTypographyDetails(TextStyle style) {
    final detailStyle = TextStyle(
      fontSize: AppFontSize.sm,
      color: AppColor.secondary.main,
    );

    return Container(
      padding: EdgeInsets.all(AppSizing.x8),
      decoration: BoxDecoration(
        color: AppColor.surface.lowest,
        borderRadius: BorderRadius.circular(AppSizing.x4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalhes:',
            style: detailStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppSizing.x4),
          Text('Família: ${style.fontFamily}', style: detailStyle),
          Text('Peso: ${style.fontWeight?.toString().split('.').last}',
              style: detailStyle),
          Text('Tamanho: ${style.fontSize}px', style: detailStyle),
          Text('Altura da linha: ${style.height}', style: detailStyle),
          Text('Espaçamento: ${style.letterSpacing}', style: detailStyle),
        ],
      ),
    );
  }
}
