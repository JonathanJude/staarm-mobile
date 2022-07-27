abstract class UserCacheService {

  //write user persisted model
  Future<void> cacheUser(Map<String, dynamic> data);

  //get user persisted model
  dynamic getCacheUser();


  //delete user persisted model
  void deleteCacheUser();

  //bool: if user persisted model exists
  Future<bool> checkIfCacheUserExists();

  //this would fetch new data from the backend & update the cache
  Future<void> revalidateCache([bool updateProvider = true]);
}