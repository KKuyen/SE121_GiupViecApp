import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../presentation/bloc/Location/default_location_cubit.dart';
import '../../../presentation/bloc/Location/location_state.dart';

class position extends StatefulWidget {
  const position({
    super.key,
  });

  @override
  State<position> createState() => positionState();
}

class positionState extends State<position> {
  @override
  void initState() {
    super.initState();
    final locationCubit =
        BlocProvider.of<DefaultLocationCubit>(context).getMyDefaultLocation(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefaultLocationCubit, LocationState>(
      builder: (context, state) {
        if (state is DefaultLocationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DefaultLocationSuccess) {
          final location = state.location;
          return ListTile(
            leading: Container(
                height: 47,
                width: 47,
                decoration: const BoxDecoration(
                    color: AppColors.xanh_main, shape: BoxShape.circle),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 27,
                )),
            title: Text(
              '${location.detailAddress}, ${location.district}, ${location.province}',
              style: const TextStyle(fontSize: 15),
            ),
            subtitle:
                Text('${location.map}', style: const TextStyle(fontSize: 13)),
            trailing: const Icon(
              Icons.navigate_next_outlined,
            ),
          );
        } else if (state is DefaultLocationError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          print("chay vao else: " + state.toString());
          return const Center(child: Text('Không tìm thấy địa chỉ'));
        }
      },
    );
  }
}
