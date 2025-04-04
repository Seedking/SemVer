///|
pub fn split(semver : String) -> SplitSemVer? {
  split_semver(semver)
}

///|
pub fn validate(semver : String) -> Bool {
  validate_semver(semver)
}

///|
pub fn parse(semver : String) -> T!SemVerParseError {
  parse_semver!(semver)
}

///|
pub fn T::to_string(self : T) -> String {
  let ret_builder = StringBuilder::new()
  ret_builder.write_string(self.major.to_string())
  if self.minor != -1 {
    ret_builder.write_char(ksymbol_dot)
    ret_builder.write_string(self.minor.to_string())
  }
  if self.patch != -1 {
    ret_builder.write_char(ksymbol_dot)
    ret_builder.write_string(self.minor.to_string())
  }
  if self.pre_release.length() > 0 {
    ret_builder.write_char(ksymbol_neg)
    for index, release_part in self.pre_release {
      if index != 0 {
        ret_builder.write_char(ksymbol_dot)
      }
      ret_builder.write_string(release_part)
    }
  }
  if self.build.length() > 0 {
    ret_builder.write_char(ksymbol_pos)
    for index, build_part in self.build {
      if index != 0 {
        ret_builder.write_char(ksymbol_dot)
      }
      ret_builder.write_string(build_part)
    }
  }
  ret_builder.to_string()
}

///|
pub fn T::is_pre_release(self : T) -> Bool {
  self.pre_release.length() > 0
}

///|
pub impl Eq for T with op_equal(self : T, other : T) -> Bool {
  guard self.major == other.major else { return false }
  guard conver_fail_to_zero(self.minor) == conver_fail_to_zero(other.minor) else {
    return false
  }
  guard conver_fail_to_zero(self.patch) == conver_fail_to_zero(other.patch) else {
    return false
  }
  compare_pre_release(self.pre_release, other.pre_release) == kmagic_eq
}

///|
pub impl Compare for T with compare(self : T, other : T) -> Int {
  let compare_major = self.major.compare(other.major)
  guard compare_major == kmagic_eq else { return compare_major }
  let compare_minor = self.minor.compare(other.minor)
  guard compare_minor == kmagic_eq else { return compare_minor }
  let compare_patch = self.patch.compare(other.patch)
  guard compare_patch == kmagic_eq else { return compare_patch }
  let compare_release = compare_pre_release(self.pre_release, other.pre_release)
  guard compare_release == kmagic_eq else { return compare_release }
  kmagic_eq
}
