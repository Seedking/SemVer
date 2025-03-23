

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
  let ret_builder: StringBuilder = StringBuilder::new()
  
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
    for release_part in self.pre_release {
      ret_builder.write_char(ksymbol_dot)
      ret_builder.write_string(release_part)
    }
  }

  if self.build.length() > 0 {
    ret_builder.write_char(ksymbol_pos)
    for build_part in self.pre_release {
      ret_builder.write_char(ksymbol_dot)
      ret_builder.write_string(build_part)
    }
  }

  return ret_builder.to_string()
}


pub fn T::is_pre_release(self : T) -> Bool {
  return if self.pre_release.length() > 0 { true } else { false }
}
