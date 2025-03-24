//#region right
///|
let right_simple = "1.0.0"

///|
let right_full = "1.0.0-alpha114+build1919"

///|
let right_full_repeat = "1.0.0-alpha114.beta514+build1919.test810"

///|
let right_full_solo_major = "1-alpha114.beta514+build1919.test810"

///|
let right_missing_build = "1.0.0-alpha114.beta514"

///|
let right_missing_release = "1.0.0+build1919.test810"

//#region wrong
///|
let wrong_empty_core_ver = "-alpha114.beta514+build1919.test810"

///|
let wrong_empty_release = "1.0.0-+build1919.test810"

///|
let wrong_empty_build = "1.0.0-alpha114.beta514+"

///|
let wrong_repeat_dot_core_ver = "..0-alpha114.beta514+build1919.test810"

///|
let wrong_repeat_dot_release = "1.0.0-alpha114..beta514+build1919.test810"

///|
let wrong_repeat_dot_build = "1.0.0-alpha114.beta514+build1919..test810"

///|
let wrong_excess_core_ver = "1.0.0.0"

///|
let wrong = "1.0.0-"

///|
test "split_semver" {
  let right_splited = @SemVer.split(right_full).unwrap()
  assert_eq!(right_splited.core_version.unwrap(), "1.0.0")
  assert_eq!(right_splited.pre_release.unwrap(), "alpha114")
  assert_eq!(right_splited.build.unwrap(), "build1919")
  let wrong_splited = split(wrong)
  assert_true!(wrong_splited.is_empty())
}

///|
test "validate_right" {
  assert_true!(@SemVer.validate(right_full))
  assert_true!(@SemVer.validate(right_full_repeat))
  assert_true!(@SemVer.validate(right_full_solo_major))
  assert_true!(@SemVer.validate(right_missing_build))
  assert_true!(@SemVer.validate(right_missing_release))
}

///|
test "validate_wrong" {
  assert_false!(@SemVer.validate(wrong_empty_core_ver))
  assert_false!(@SemVer.validate(wrong_empty_release))
  assert_false!(@SemVer.validate(wrong_empty_build))
  assert_false!(@SemVer.validate(wrong_repeat_dot_core_ver))
  assert_false!(@SemVer.validate(wrong_repeat_dot_release))
  assert_false!(@SemVer.validate(wrong_repeat_dot_build))
  assert_false!(@SemVer.validate(wrong_excess_core_ver))
}

///|
test "compare" {
  let v1_0_0 = @SemVer.T::{
    major: 1,
    minor: 0,
    patch: 0,
    pre_release: [],
    build: [],
  }
  let v2 = @SemVer.T::{
    major: 2,
    minor: -1,
    patch: -1,
    pre_release: [],
    build: [],
  }
  let v2_0_0 = @SemVer.T::{
    major: 2,
    minor: 0,
    patch: 0,
    pre_release: [],
    build: [],
  }
  let v2_1_0 = @SemVer.T::{
    major: 2,
    minor: 1,
    patch: 0,
    pre_release: [],
    build: [],
  }
  let v2_1_1 = @SemVer.T::{
    major: 2,
    minor: 1,
    patch: 1,
    pre_release: [],
    build: [],
  }
  let v1_0_0_release = @SemVer.T::{
    major: 1,
    minor: 0,
    patch: 0,
    pre_release: ["alpha114"],
    build: [],
  }
  let v1_0_0_build = @SemVer.T::{
    major: 1,
    minor: 0,
    patch: 0,
    pre_release: [],
    build: ["build1919"],
  }
  assert_false!(v1_0_0 == v2_0_0)
  assert_false!(v2_0_0 == v2_1_0)
  assert_false!(v2_1_0 == v2_1_1)
  assert_false!(v1_0_0 == v1_0_0_release)
  assert_true!(v2 == v2_0_0)
  assert_true!(v1_0_0 < v2_0_0)
  assert_true!(v2_0_0 < v2_1_0)
  assert_true!(v2_1_0 < v2_1_1)
  assert_true!(v1_0_0_release < v1_0_0)
  assert_true!(v1_0_0 == v1_0_0_build)
}

///|
test "parse" {
  let v_simple = @SemVer.T::{
    major: 1,
    minor: 0,
    patch: 0,
    pre_release: [],
    build: [],
  }
  let v_full = @SemVer.T::{
    major: 1,
    minor: 0,
    patch: 0,
    pre_release: ["alpha114"],
    build: ["build1919"],
  }
  let v_repeat = @SemVer.T::{
    major: 1,
    minor: 0,
    patch: 0,
    pre_release: ["alpha114", "beta514"],
    build: ["build1919", "test810"],
  }
  assert_true!(v_simple == @SemVer.parse?(right_simple).unwrap())
  assert_true!(v_full == @SemVer.parse?(right_full).unwrap())
  assert_true!(v_repeat == @SemVer.parse?(right_full_repeat).unwrap())
}

///|
test "to_string" {
  let v_simple = @SemVer.T::{
    major: 1,
    minor: 0,
    patch: 0,
    pre_release: [],
    build: [],
  }
  let v_solo_major = @SemVer.T::{
    major: 1,
    minor: -1,
    patch: -1,
    pre_release: ["alpha114", "beta514"],
    build: ["build1919", "test810"],
  }
  assert_eq!(v_simple.to_string(), right_simple)
  assert_eq!(v_solo_major.to_string(), right_full_solo_major)
}

test "is_pre_release" {
  let v_is_not_release = @SemVer.T::{
    major: 1,
    minor: 0,
    patch: 0,
    pre_release: [],
    build: [],
  }
  let v_is_release = @SemVer.T::{
    major: 1,
    minor: -1,
    patch: -1,
    pre_release: ["alpha114", "beta514"],
    build: ["build1919", "test810"],
  }
  assert_false!(v_is_not_release.is_pre_release())
  assert_true!(v_is_release.is_pre_release())
}
