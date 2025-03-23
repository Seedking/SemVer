///|
pub struct SplitSemVer {
  mut core_version : String?
  mut pre_release : String?
  mut build : String?
}

///|
pub struct T {
  major : Int
  minor : Int
  patch : Int
  pre_release : Array[String]
  build : Array[String]
}
