import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spray/core/extensions/app_extensions.dart';
import 'package:spray/core/widgets/back_button.dart';
import 'package:spray/core/widgets/custom_textfield.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';
import 'package:spray/features/spray/presentation/providers/search_receiver_provider.dart';
import 'package:spray/features/spray/presentation/widgets/spray_receiver_container.dart';
import 'package:spray/theme/app_colors.dart';

@RoutePage()
class SpraySomeonePage extends ConsumerStatefulWidget {
  const SpraySomeonePage({super.key});

  @override
  ConsumerState<SpraySomeonePage> createState() => _SpraySomeonePageState();
}

class _SpraySomeonePageState extends ConsumerState<SpraySomeonePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_searchUser);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _searchUser() {
    String query = controller.text.trim();
    ref.read(searchReceiversProvider.notifier).search(query);
  }

  @override
  Widget build(BuildContext context) {
    bool loading = ref.watch(searchReceiversProvider.select((u) => u.loading));
    List<SprayReceiver> receivers = ref.watch(searchReceiversProvider.select((u) => u.receivers));

    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Spray Someone',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.brandDark,
            ),
          ),
          leading: const CustomBackButton(),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search and ask the receiver to share their spray code with you.",
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: controller,
                    hint: "Search by username",
                    prefix: Icon(
                      IconsaxPlusLinear.search_normal_1,
                      color: AppColors.textDark,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceBackgroundLighter,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Skeletonizer(
                  enabled: loading,
                  child: ListView.separated(
                    itemBuilder: (_, index) {
                      SprayReceiver receiver = receivers[index];

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 350),
                        child: SlideAnimation(
                          verticalOffset: index % 2 == 0 ? 20 : -20,
                          child: FadeInAnimation(
                            child: SprayReceiverContainer(receiver: receiver),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemCount: receivers.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
