/// Constantes que gobiernan el comportamiento de paginación del Feed.
///
/// Centralizar estos valores aquí evita "números mágicos" dispersos por el
/// código y permite ajustar el rendimiento y coste de consultas en un solo lugar.
const int kIdeasPageSize = 15;
const int kDoodlesPageSize = 20;

/// Número de items que se piden a Supabase cuando el orden es aleatorio.
///
/// Se pide un lote grande para luego hacer shuffle en cliente, evitando
/// así la necesidad de una función RPC de Postgres `ORDER BY RANDOM()`.
const int kRandomFetchSize = 60;
