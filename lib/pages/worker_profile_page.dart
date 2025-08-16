import 'package:flutter_coworkers/controllers/worker_profile_controller.dart';
import 'package:flutter_coworkers/models/worker_model.dart';
import 'package:flutter_coworkers/widgets/secondary_button.dart';
import 'package:flutter_coworkers/widgets/section_title.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';
import '../config/app_format.dart';
import '../config/appwrite.dart';
import '../config/enums.dart';
import '../controllers/user_controller.dart';
import '../widgets/header_worker.dart';

class WorkerProfilePage extends StatefulWidget {
  const WorkerProfilePage({super.key, required this.worker});
  final WorkerModel worker;

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  final workerProfileController = Get.put(WorkerProfileController());
  final userController = Get.put(UserController());

  @override
  void initState() {
    workerProfileController.checkHiredBy(widget.worker.$id);
    super.initState();
  }

  @override
  void dispose() {
    workerProfileController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        String recruiterId = workerProfileController.recruiterId;
        if (recruiterId == '') {
          return UnconstrainedBox(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: DView.loadingCircle(),
            ),
          );
        }
        if (recruiterId == 'Available') {
          return hireNow();
        }
        if (recruiterId == userController.data.$id) {
          return hireByYou();
        }
        return hireByOther();
      }),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Container(
                height: 172,
                decoration: const BoxDecoration(
                  color: AppColor.bgHeader,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 65),
                    child: HeaderWorker(
                      title: 'Worker Profile',
                      subtitle: 'Details are matters',
                      iconLeft: 'assets/ic_back.png',
                      functionLeft: () => Navigator.pop(context),
                      iconRight: 'assets/ic_other.png',
                      functionRight: () {},
                    ),
                  ),
                  DView.spaceHeight(24),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 6),
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          Appwrite.imageURL(widget.worker.image),
                          width: 136,
                          height: 136,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Obx(() {
                        String recruiterId =
                            workerProfileController.recruiterId;
                        if (recruiterId == '') return DView.nothing();
                        if (recruiterId == 'Available') return DView.nothing();
                        if (recruiterId == userController.data.$id) {
                          return hiredByYouText();
                        }
                        return hiredByOtherText();
                      }),
                    ],
                  ),
                  DView.spaceHeight(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.worker.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      DView.spaceWidth(4),
                      Image.asset(
                        'assets/ic_verified.png',
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                  Obx(() {
                    String recruiterId = workerProfileController.recruiterId;
                    String txtAvailable = recruiterId == 'Available'
                        ? ' • Available'
                        : '';
                    return Text(
                      '${widget.worker.location} • ${widget.worker.experience}yrs$txtAvailable',
                      style: const TextStyle(color: Colors.grey),
                    );
                  }),
                ],
              ),
            ],
          ),
          DView.spaceHeight(30),
          const SectionTitle(text: 'About', autoPadding: true),
          DView.spaceHeight(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.worker.about,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          DView.spaceHeight(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                RatingBar.builder(
                  initialRating: widget.worker.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.all(0),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {},
                  ignoreGestures: true,
                ),
                DView.spaceWidth(8),
                Text(
                  '(${AppFormat.number(widget.worker.ratingCount)})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          DView.spaceHeight(30),
          const SectionTitle(text: 'My Strengths', autoPadding: true),
          DView.spaceHeight(8),
          Column(
            children: widget.worker.strengths.map((e) {
              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 20),
                child: Row(
                  children: [
                    Radio(
                      visualDensity: const VisualDensity(
                        vertical: -3,
                        horizontal: -4,
                      ),
                      value: true,
                      groupValue: true,
                      onChanged: (value) {},
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    Text(
                      e,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget hireByOther() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppFormat.price(widget.worker.hourRate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('per hour'),
              ],
            ),
          ),
          SizedBox(
            width: 166,
            child: SecondaryButton(
              onPressed: () {},
              child: const Text('Not Available'),
            ),
          ),
        ],
      ),
    );
  }

  Widget hireByYou() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              onPressed: () {},
              child: const Text('Message'),
            ),
          ),
          DView.spaceWidth(),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: const Text('Give Rating'),
            ),
          ),
        ],
      ),
    );
  }

  Widget hireNow() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppFormat.price(widget.worker.hourRate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('per hour'),
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: FilledButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.booking.name,
                  arguments: widget.worker,
                );
              },
              child: const Text('Hire Now'),
            ),
          ),
        ],
      ),
    );
  }

  Positioned hiredByYouText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, 6),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffBFA8FF),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: const Text(
              'HIRED BY YOU',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned hiredByOtherText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, 6),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffFF7179),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: const Text(
              'HIRED BY OTHER',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
