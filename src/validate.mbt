
fn check_chars_is_valid(semver: String) -> Bool{
  for char in semver {
    if is_valid_char(char) != true { return false }
  }
  return true
}


fn check_symbols_in_limit(semver: String) -> Bool{
  let mut pos_count = 0;
  let mut neg_count = 0;

  for char in semver {
    if char == ksymbol_pos { pos_count += 1 }
    if char == ksymbol_neg { neg_count += 1 }
  }

  return pos_count <= 1 && neg_count <= 1
}


fn check_dots_not_consecutive(semver: String) -> Bool {
  for index, char in semver {
    guard index != 0 else { continue }

    if semver[index - 1] == ksymbol_dot && char == ksymbol_dot { return false }
  }
  return true
}


fn check_neg_pos_symbols_is_order(semver: String) -> Bool{
  let pos_index: Int = semver.index_of(ksymbol_pos.to_string())
  let neg_index: Int = semver.index_of(ksymbol_neg.to_string())

  if pos_index != -1 && neg_index != -1 && pos_index < neg_index { return false }

  return true;
}

fn check_core_version(core_version: String) -> Bool{
  if (core_version.length() == 0) { return false }

  let split_version = core_version.split(ksymbol_dot.to_string())
  if split_version.count() > 3 { return false }
  for ver_part in split_version {
    if ver_part.length() == 0 { return false }
    for char in ver_part {
      if not(is_valid_digit(char)) { return false }
    }
  }

  return true
}


fn check_pre_release(pre_release: String) -> Bool{
  if (pre_release.length() == 0) { return false }
  
  let split_release = pre_release.split(ksymbol_dot.to_string())
  for release_part in split_release {
    if release_part.length() == 0 { return false }
    for char in release_part {
      if not(is_valid_letter(char) || is_valid_digit(char)) { return false }
    }
  }

  return true
}


fn check_build(build: String) -> Bool{
  if (build.length() == 0) { return false }

  let split_build = build.split(ksymbol_dot.to_string())
  for build_part in split_build {
    if build_part.length() == 0 { return false }
    for char in build_part {
      if not(is_valid_letter(char) || is_valid_digit(char)) { return false }
    }
  }

  return true
}


fn check_split_part_is_valide(semver: String) -> Bool {
  let splited = split_semver(semver)
  if splited is None { return false }
  
  let split_unwarp = splited.unwrap()
  if split_unwarp.core_version.is_empty() { return false }
  if not(check_core_version(split_unwarp.core_version.unwrap())) { return false }
  if not(split_unwarp.pre_release.is_empty()) { 
    if not(check_pre_release(split_unwarp.pre_release.unwrap())) { return false }
  }
  if not(split_unwarp.build.is_empty()) { 
    if not(check_build(split_unwarp.build.unwrap())) { return false }
  }

  return true
}


//#region important

fn validate_semver(semver: String) -> Bool{
  guard semver.length() != 0 else { return false }
  guard check_chars_is_valid(semver) else { return false }
  guard check_symbols_in_limit(semver) else { return false }
  guard check_dots_not_consecutive(semver) else { return false }
  guard check_neg_pos_symbols_is_order(semver) else { return false }
  guard check_split_part_is_valide(semver) else { return false }
  

  return true
}

//#endregion