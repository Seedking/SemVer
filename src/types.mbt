
pub struct SegmentedSemVer {
  mut core_version : String?
  mut pre_release : String?
  mut build : String?
}

pub struct T {
  major : UInt16
  minor : UInt16
  patch : UInt16
  pre_release : Array[String]
  build : Array[String]
}
