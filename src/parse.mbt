


fn parse_semver(semver: String) -> T!SemVerParseError{
  guard validate_semver(semver) else { raise SemVerParseError }
  let split_parts = split_semver(semver).unwrap()

  let mut major = kmagic_failed_num
  let mut minor = kmagic_failed_num
  let mut patch = kmagic_failed_num
  let pre_release : Array[String] = []
  let build : Array[String] = []
  
  let split_core_ver = split_parts.core_version.unwrap().split(ksymbol_dot.to_string()).to_array();

  major = @strconv.parse_int?(split_core_ver[0]).unwrap()
  if split_core_ver.length() >= 2 { minor = @strconv.parse_int?(split_core_ver[1]).unwrap()}
  if split_core_ver.length() >= 3 { patch = @strconv.parse_int?(split_core_ver[2]).unwrap()}

  if not(split_parts.pre_release.is_empty()) {
    pre_release.append(split_parts.pre_release.unwrap().split(ksymbol_dot.to_string()).to_array())
  }

  if not(split_parts.build.is_empty()) {
    build.append(split_parts.build.unwrap().split(ksymbol_dot.to_string()).to_array())
  }
  
  

  return T::{major : major, minor : minor, patch : patch, pre_release : pre_release, build : build}
}