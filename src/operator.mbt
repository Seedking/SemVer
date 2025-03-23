///|
fn compare_release_part(part_a : String, part_b : String) -> Int {
  let a_is_num = part_a.fold(init=true, fn(acc, c) { acc && is_valid_digit(c) })
  let b_is_num = part_b.fold(init=true, fn(acc, c) { acc && is_valid_digit(c) })
  if a_is_num && not(b_is_num) {
    return kmagic_smaller
  }
  if not(a_is_num) && b_is_num {
    return kmagic_greater
  }
  if a_is_num && b_is_num {
    let a_num = @strconv.parse_int?(part_a, base=0).unwrap()
    let b_num = @strconv.parse_int?(part_b, base=0).unwrap()
    return a_num.compare(b_num)
  }
  part_a.compare(part_b)
}

///|
fn compare_pre_release(
  release_a : Array[String],
  release_b : Array[String]
) -> Int {
  let a_empty = release_a.is_empty()
  let b_empty = release_b.is_empty()
  if a_empty && not(b_empty) {
    return kmagic_greater
  }
  if not(a_empty) && b_empty {
    return kmagic_smaller
  }
  let len = @math.minimum(release_a.length(), release_b.length())
  for index in 0..<len {
    let result = compare_release_part(release_a[index], release_b[index])
    if result != kmagic_eq {
      return result
    }
  }
  release_a.length().compare(release_b.length())
}
