

pub fn split(semver: String) -> SplitSemVer? {
  return split_semver(semver)
}


pub fn validate(semver : String) -> Bool {
  return validate_semver(semver)
}


pub fn parse(semver : String) -> T? {
  return parse_semver(semver)
}


pub fn T::to_string(self : T) -> String {
  return ""
}


pub fn T::is_prerelease(self : T) -> Bool {
  return if self.pre_release.length() > 0 { true } else { false }
}
