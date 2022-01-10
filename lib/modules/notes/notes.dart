import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/layout/cubit/cubit.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/models/add_note_model.dart';
import 'package:visual_note/modules/note_details/note_details.dart';
import 'package:visual_note/shared/components/components.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).notes.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildProductItem(
                model: AppCubit.get(context).notes[index],
                context: context,
                index: index),
            separatorBuilder: (context, index) => SizedBox(
              height: 5,
            ),
            itemCount: AppCubit.get(context).notes.length,
          ),
          fallback: (context) => AppCubit.get(context).notes.length == 0
              ? Center(
                  child: Text('No Item'),
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildProductItem({required AddNoteModel model, context, index}) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            NoteDetailsScreen(
              model: AppCubit.get(context).notes[index],
              index: index,
            ));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(model.image),
                    )),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.delete), onPressed: () {
                                // AppCubit.get(context).removeNote();
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        model.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      model.status!
                          ? Text(
                              'Opened',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Text(
                              'Closed',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      Text(
                        model.dateTime!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
