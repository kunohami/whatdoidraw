/// Define los modos de ordenación disponibles para las pestañas del Feed.
enum FeedSortOrder {
  /// Ordena el contenido de más reciente a más antiguo.
  recent,

  /// Devuelve el contenido en orden aleatorio (shuffle en cliente).
  random,

  /// Ordena por número de likes (más populares primero).
  likes,
}
