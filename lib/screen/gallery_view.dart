import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos/blocs/blocs.dart';
import 'package:photos/widgets/display_photos.dart';

class GalleryView extends StatefulWidget {
  final PhotosBloc photosBloc;

  GalleryView({
    Key key,
    @required this.photosBloc,
  }) : super(key: key);

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      cubit: widget.photosBloc,
      builder: (context, state) {
        if (state is PhotosLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PhotosLoaded) {
          return _buildGalleryScrollingList(context, state);
        } else {
          return Container();
        }
      }
    );
  }

  Widget _buildGalleryScrollingList(BuildContext context, PhotosLoaded state) {
    return DisplayPhotos(photos: state.photos);
  }
}
