enum APIResultType {
  loading,
  success,
  failure,
  sessionExpired,
  noInternet,
  unauthorised,
  cacheError,
  notFound,
  timeOut
}

enum NetworkResultType {
  success,
  error,
  cacheError,
  timeOut,
  noInternet,
  unauthorised,
  notFound
}

enum UserContentType {
  story,
  general,
}

enum MediaType { image, video }

enum FilterType {
  date,
  time,
  city,
  reciter,
  typeOfEvent,
  event,
  age,
  organization
}

enum ImageType {
  local,
  network,
}

enum TimeSpan {
  max,
  threeYear,
  oneYear,
  sixMonths,
  threeMonths,
  oneMonth,
}
