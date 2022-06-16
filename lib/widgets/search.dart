import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/providers/home_provider.dart';
import 'package:radio_station/services/station_api_service.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        child: Row(
          children: [
            const IconButton(
                icon: Icon(
                  Icons.search,
                  size: 20,
                  color: Color(0xffA9A9A9),
                ),
                onPressed: null),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffA9A9A9),
                  ),
                ),
                onChanged: _onSearchTextChanged,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                size: 20,
              ),
              onPressed: () {
                controller.clear();
                _onSearchTextChanged('');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSearchTextChanged(String text) async {
    print('searching - $text');
    final stations = await StationApiService().getStations(name: text.trim());
    if (stations.length >= StationApiService().numberOfItems) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.update();
    }
  }
}
