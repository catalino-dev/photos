import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos/blocs/blocs.dart';
import 'package:photos/model/model.dart';

enum ExtraAction { deleteCollection }
typedef MenuAction = Function(ExtraAction action);

class ExtraActions extends StatelessWidget {
  final Collection collection;
  final MenuAction menuAction;

  ExtraActions({
    @required this.collection,
    @required this.menuAction,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      onSelected: menuAction,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.deleteCollection,
          child: Text('Delete Collection'),
        ),
      ],
    );
  }
}
