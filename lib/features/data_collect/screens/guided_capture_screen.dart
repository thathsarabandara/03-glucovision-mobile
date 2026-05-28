import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_2/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:path_provider/path_provider.dart';

import '../services/api_service.dart';
import '../providers/data_collect_provider.dart';

class GuidedCaptureScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> sessionParams;
  const GuidedCaptureScreen({super.key, required this.sessionParams});

  @override
  ConsumerState<GuidedCaptureScreen> createState() => _GuidedCaptureScreenState();
}

class _GuidedCaptureScreenState extends ConsumerState<GuidedCaptureScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  bool _isScanning = true;
  bool _isUploading = false;
  final DataCollectApiService _apiService = DataCollectApiService();

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;
    
    this.arSessionManager!.onInitialize(
      showFeaturePoints: true,
      showPlanes: true,
      showWorldOrigin: true,
      handlePans: true,
      handleRotation: true,
    );
    this.arObjectManager!.onInitialize();
  }

  Future<void> _captureData() async {
    setState(() => _isUploading = true);
    try {
      // 1. Capture snapshot (in a real app, this would get a high-res image)
      // Since ARView doesn't expose a direct snapshot method easily in all versions, 
      // we assume we capture the image via the plugin or native channel.
      // For demonstration, we create a dummy file.
      final directory = await getTemporaryDirectory();
      final imageFile = File('${directory.path}/snapshot.jpg');
      await imageFile.writeAsBytes([0]); // Dummy byte

      // 2. Extract AR Data
      // In a real implementation, you'd pull the transform matrix from the camera manager
      final arData = {
        'camera_transform': math.Matrix4.identity().storage.toList(),
        'plane_mesh': [],
        'point_cloud': [],
        'scale_factor': 1.0,
      };

      // 3. Metadata
      final selectedFoodId = ref.read(selectedFoodIdProvider);
      final metadata = {
        'device_model': 'Flutter Emulator',
        'plate_type': widget.sessionParams['plate_type'] ?? 'Unknown',
        'background_type': widget.sessionParams['background_type'] ?? 'Unknown',
        'food_id': selectedFoodId ?? 'unknown',
        'ground_truth_weight_grams': 200.0,
      };

      // 4. Upload
      final response = await _apiService.uploadData(
        imageFile: imageFile,
        arData: jsonEncode(arData),
        metadata: jsonEncode(metadata),
      );

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload successful!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload failed.')));
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Capture'),
      ),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          if (_isScanning)
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Slowly move your phone to scan the table. Look for the AR grid.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: _captureData,
                      icon: const Icon(Icons.camera),
                      label: const Text('CAPTURE'),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
