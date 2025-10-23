import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/access_requests_state.dart';
import 'create_access_request_screen.dart';
import '../widgets/access_request_table.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AccessRequestsScreen extends StatelessWidget {
  const AccessRequestsScreen({super.key});

  void _deleteWithUndo(BuildContext context, String id) {
    final state = context.read<AccessRequestsState>();
    state.remove(id);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Заявка удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => context.read<AccessRequestsState>().undoRemove(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessRequestsState>(
      builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Система выдачи доступов')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Галерея ресурсов', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _Thumb(url: 'https://media.istockphoto.com/id/525151431/ru/%D1%84%D0%BE%D1%82%D0%BE/%D1%81%D0%B5%D0%B2%D0%B5%D1%80%D0%BD%D1%8B%D0%B9-%D0%BE%D1%81%D1%82%D1%80%D0%BE%D0%B2-%D0%BA%D0%BE%D1%80%D0%B8%D1%87%D0%BD%D0%B5%D0%B2%D1%8B%D0%B9-%D0%BA%D0%B8%D0%B2%D0%B8-apteryx-mantelli.jpg?s=612x612&w=0&k=20&c=t3fVOSWgyrN4hJ7xV3ck5SesgEkn595-BJI5krqMZ_s='),
                    _Thumb(url: 'https://www.ptichka.ru/data/cache/2020may/26/01/123634_44994.jpg'),
                    _Thumb(url: 'https://images.techinsider.ru/upload/img_cache/8bf/8bfb128920827c35ee7cc419e1dc6c52_cropped_666x463.jpg'),
                    _Thumb(url: 'https://farm4.static.flickr.com/3648/3493786533_cf5cdaf716_b.jpg'),
                    _Thumb(url: 'https://cdnn21.img.ria.ru/images/67599/44/675994450_0:0:565:319_650x0_80_0_0_1577e82a5380ea70543b91e10b763158.jpg'),
                    _Thumb(url: 'https://i.pinimg.com/736x/55/1b/c5/551bc569b001f76d766e757084fdc4a5.jpg'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AccessRequestTable(
                items: state.items,
                onToggleApproval: (id) => state.toggleApproval(id),
                onDelete: (id) => _deleteWithUndo(context, id),
                onItemTap: null,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreateAccessRequestScreen()),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

}


class _Thumb extends StatelessWidget {
  final String url;
  const _Thumb({required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, _) => const SizedBox(
            width: 160,
            child: Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, _, __) => const SizedBox(
            width: 160,
            child: Center(child: Icon(Icons.error)),
          ),
          width: 160,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

