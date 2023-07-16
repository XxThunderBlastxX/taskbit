import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskbit/src/feature/tasks/domain/model/appwrite_task_model/appwrite_task_model.dart';

import '../../../app/common/utils/random_avatar.dart';
import '../../../app/theme/theme.dart';
import '../../../provider/global_providers.dart';
import '../../completed_tasks/presentation/completed_tab.dart';
import '../../on_progress_tasks/presentation/on_progress_tab.dart';
import '../data/repository/task_repository.dart';
import 'provider/tasks_provider.dart';
import 'widgets/add_new_task_header.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadAllTasks();
    subscribeDatabase();
  }

  void loadAllTasks() {
    final res = ref.watch(getDocumentListProvider);
    final taskList = ref.watch(taskNotifierProvider.notifier);

    res.whenData(
      (docList) => docList.documents.map(
        (doc) => taskList.addTask(
          AppwriteTaskModel(
            $id: doc.$id,
            $collectionId: doc.$collectionId,
            $databaseId: doc.$databaseId,
            userId: doc.data['userId'],
            title: doc.data['title'],
            description: doc.data['description'],
            isCompleted: doc.data['isCompleted'],
            category: doc.data['category'],
            createdAt: doc.data['createdAt'],
            updatedAt: doc.data['updatedAt'],
          ),
        ),
      ),
    );
  }

  void subscribeDatabase() {
    final dbId = ref.watch(databaseIdProvider);
    final collectionId = ref.watch(collectionIdProvider);
    final taskList = ref.watch(taskNotifierProvider.notifier);

    final appwriteStream = ref.watch(appwriteStreamProvider);

    final realtimeSub = appwriteStream
        .subscribe(['databases.$dbId.collections.$collectionId.documents']);

    realtimeSub.stream.listen((data) {
      if (data.payload.isNotEmpty) {
        if (data.events
            .contains('databases.*.collections.*.documents.*.create')) {
          taskList.addTask(AppwriteTaskModel.fromJson(data.payload));
        } else if (data.events
            .contains('databases.*.collections.*.documents.*.delete')) {
          taskList.removeTask(AppwriteTaskModel.fromJson(data.payload));
        } else if (data.events
            .contains('databases.*.collections.*.documents.*.update')) {
          taskList.setTaskComplete(AppwriteTaskModel.fromJson(data.payload));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localUser = ref.watch(localUserProvider);
    final avatar = ref.watch(
      randomAvatarProvider(localUser?.name ?? 'Anonymous'),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: CircleAvatar(
            backgroundColor: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(3.5),
              child: avatar,
            ),
          ),
          leadingWidth: 80.w,
          bottom: PreferredSize(
            preferredSize: Size(1.sw, 82.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  const AddNewTaskHeader(),
                  18.verticalSpace,
                  const TabBar(
                    tabs: [
                      Text('On Progress'),
                      Text('Completed'),
                    ],
                    physics: BouncingScrollPhysics(),
                  ),
                ],
              ),
            ),
          ),
          title: RichText(
            text: TextSpan(
              text: 'Hello,',
              style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                color: Colors.black54,
                fontSize: 13.sp,
              ),
              children: [
                TextSpan(
                  text: '\n${localUser!.name}',
                  style: AppTheme.theme.textTheme.labelSmall!,
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 8.h,
          ),
          child: const TabBarView(
            children: [
              OnProgressTab(),
              CompletedTab(),
            ],
          ),
        ),
      ),
    );
  }
}
