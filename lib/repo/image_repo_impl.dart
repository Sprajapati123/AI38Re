import 'package:ai38re/repo/image_repo.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class ImageRepoImpl implements ImageRepo {
  final cloudinary = CloudinaryPublic(
    "dvztiygb9",
    "projects",
    cache: false,
  );

  @override
  Future<String> uploadImage(String filePath) async {
    final response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        filePath,
        resourceType: CloudinaryResourceType.Image,
        folder: "products",
      ),
    );
    return response.secureUrl;
  }
}
