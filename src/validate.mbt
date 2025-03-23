///|
fn check_chars_is_valid(semver : String) -> Bool {
  not(semver.iter().any(fn(c) { is_valid_char(c) }))
}

///|
fn check_symbols_in_limit(semver : String) -> Bool {
  let (pos_count, neg_count) = semver
    .iter()
    .fold(init=(0, 0), fn(acc, c) {
      if c == ksymbol_pos {
        (acc.0 + 1, acc.1)
      } else if c == ksymbol_neg {
        (acc.0, acc.1 + 1)
      } else {
        acc
      }
    })
  pos_count <= 1 && neg_count <= 1
}

///|
fn check_dots_not_consecutive(semver : String) -> Bool {
  for index, char in semver {
    guard index != 0 else { continue }
    if semver[index - 1] == ksymbol_dot && char == ksymbol_dot {
      return false
    }
  }
  true
}

///|
fn check_neg_pos_symbols_is_order(semver : String) -> Bool {
  let pos_index = semver.index_of(ksymbol_pos.to_string())
  let neg_index = semver.index_of(ksymbol_neg.to_string())
  if pos_index != kmagic_failed_num &&
    neg_index != kmagic_failed_num &&
    pos_index < neg_index {
    false
  } else {
    true
  }
}

///|
fn check_core_version(core_version : String) -> Bool {
  if core_version.length() == 0 {
    return false
  }
  let split_version = core_version.split(ksymbol_dot.to_string())
  if split_version.count() > 3 {
    return false
  }
  for ver_part in split_version {
    if ver_part.length() == 0 {
      return false
    }
    for char in ver_part {
      if not(is_valid_digit(char)) {
        return false
      }
    }
  }
  true
}

///|
fn check_pre_release(pre_release : String) -> Bool {
  if pre_release.length() == 0 {
    return false
  }
  let split_release = pre_release.split(ksymbol_dot.to_string())
  for release_part in split_release {
    if release_part.length() == 0 {
      return false
    }
    for char in release_part {
      if not(is_valid_letter(char) || is_valid_digit(char)) {
        return false
      }
    }
  }
  true
}

///|
fn check_build(build : String) -> Bool {
  if build.length() == 0 {
    return false
  }
  let split_build = build.split(ksymbol_dot.to_string())
  for build_part in split_build {
    if build_part.length() == 0 {
      return false
    }
    for char in build_part {
      if not(is_valid_letter(char) || is_valid_digit(char)) {
        return false
      }
    }
  }
  true
}

///|
fn check_split_part_is_valide(semver : String) -> Bool {
  let split_parts = split_semver(semver)
  if split_parts is None {
    return false
  }
  let split_parts_unwarp = split_parts.unwrap()
  if split_parts_unwarp.core_version.is_empty() {
    return false
  }
  if not(check_core_version(split_parts_unwarp.core_version.unwrap())) {
    return false
  }
  if not(split_parts_unwarp.pre_release.is_empty()) {
    if not(check_pre_release(split_parts_unwarp.pre_release.unwrap())) {
      return false
    }
  }
  if not(split_parts_unwarp.build.is_empty()) {
    if not(check_build(split_parts_unwarp.build.unwrap())) {
      return false
    }
  }
  true
}

//#region important

///|
fn validate_semver(semver : String) -> Bool {
  guard semver.length() != 0 else { return false }
  guard check_chars_is_valid(semver) else { return false }
  guard check_symbols_in_limit(semver) else { return false }
  guard check_dots_not_consecutive(semver) else { return false }
  guard check_neg_pos_symbols_is_order(semver) else { return false }
  guard check_split_part_is_valide(semver) else { return false }
  true
}

//#endregion
