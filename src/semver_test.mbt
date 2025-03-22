
//#region right
let right_full = "1.0.0-alpha114+build1919"

let right_full_repeat = "1.0.0-alpha114.beta514+build1919.test810"

let right_full_solo_major = "1-alpha114.beta514+build1919.test810"

let right_missing_build = "1.0.0-alpha114.beta514"

let right_missing_release = "1.0.0+build1919.test810"


//#region wrong
let wrong_empty_core_ver = "-alpha114.beta514+build1919.test810"

let wrong_empty_release = "1.0.0-+build1919.test810"

let wrong_empty_build = "1.0.0-alpha114.beta514+"

let wrong_repeat_dot_core_ver = "..0-alpha114.beta514+build1919.test810"

let wrong_repeat_dot_release = "1.0.0-alpha114..beta514+build1919.test810"

let wrong_repeat_dot_build = "1.0.0-alpha114.beta514+build1919..test810"

let wrong_excess_core_ver = "1.0.0.0"

let wrong = "1.0.0-"


test "split_semver" {
  let right_splited = @SemVer.split(right_full).unwrap()
  assert_eq!(right_splited.core_version.unwrap(), "1.0.0")
  assert_eq!(right_splited.pre_release.unwrap(), "alpha114")
  assert_eq!(right_splited.build.unwrap(), "build1919")

  let wrong_splited = split(wrong)
  assert_true!(wrong_splited.is_empty())
}

test "validate_right" {
  assert_true!(@SemVer.validate(right_full))
  assert_true!(@SemVer.validate(right_full_repeat))
  assert_true!(@SemVer.validate(right_full_solo_major))
  assert_true!(@SemVer.validate(right_missing_build))
  assert_true!(@SemVer.validate(right_missing_release))
}

test "validate_wrong" {
  assert_false!(@SemVer.validate(wrong_empty_core_ver))
  assert_false!(@SemVer.validate(wrong_empty_release))
  assert_false!(@SemVer.validate(wrong_empty_build))
  assert_false!(@SemVer.validate(wrong_repeat_dot_core_ver))
  assert_false!(@SemVer.validate(wrong_repeat_dot_release))
  assert_false!(@SemVer.validate(wrong_repeat_dot_build))
  assert_false!(@SemVer.validate(wrong_excess_core_ver))
}