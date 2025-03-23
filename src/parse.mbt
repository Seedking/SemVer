///|
fn parse_semver(semver : String) -> T!SemVerParseError {
  guard validate_semver(semver) else { raise SemVerParseError }
  let split_parts = split_semver(semver).unwrap()
  let split_core_ver = split_parts.core_version
    .unwrap()
    .split(ksymbol_dot.to_string())
    .to_array()
  T::{
    major: @strconv.parse_int?(split_core_ver[0]).unwrap(),
    minor: if split_core_ver.length() >= 2 {
      @strconv.parse_int?(split_core_ver[1]).unwrap()
    } else {
      kmagic_failed_num
    },
    patch: if split_core_ver.length() >= 3 {
      @strconv.parse_int?(split_core_ver[2]).unwrap()
    } else {
      kmagic_failed_num
    },
    pre_release: if split_parts.pre_release.is_empty() {
      []
    } else {
      split_parts.pre_release.unwrap().split(ksymbol_dot.to_string()).to_array()
    },
    build: if split_parts.build.is_empty() {
      []
    } else {
      split_parts.build.unwrap().split(ksymbol_dot.to_string()).to_array()
    },
  }
}
