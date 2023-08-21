import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskbit/src/app/env/env.dart';

import '../../../app/common/utils/random_avatar.dart';
import '../../../app/theme/theme.dart';
import '../../../provider/provider.dart';
import '../../completed_tasks/presentation/completed_tab.dart';
import '../../on_progress_tasks/presentation/on_progress_tab.dart';
import '../data/repository/task_repository.dart';
import '../domain/model/appwrite_task_model/appwrite_task_model.dart';
import '../domain/model/task_model/task_model.dart';
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

  void loadAllTasks() async {
    final taskRepo = ref.watch(taskRepositoryProvider);
    final taskList = ref.watch(taskNotifierProvider.notifier);

    final res = await taskRepo.getAllTasks();

    res.fold(
      (docList) {
        taskList.addTaskList(
          docList.documents.map(
            (doc) {
              return AppwriteTaskModel(
                $id: doc.$id,
                $collectionId: doc.$collectionId,
                $databaseId: doc.$databaseId,
                userId: doc.data['userId'] as String,
                title: doc.data['title'] as String,
                description: doc.data['description'] as String,
                isCompleted: doc.data['isCompleted'] as bool,
                category:
                    TaskCategory.values.byName(doc.data['category'] as String),
                createdAt: DateTime.parse(doc.data['createdAt'] as String),
                updatedAt: DateTime.parse(doc.data['updatedAt'] as String),
              );
            },
          ).toList(),
        );
      },
      (failure) => null,
    );
  }

  void subscribeDatabase() {
    final String dbId = Env.databaseID;
    final String collectionId = Env.collectionID;
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
