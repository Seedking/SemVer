
let ksymbol_dot = '.'

let ksymbol_pos = '+'

let ksymbol_neg = '-'

fn is_valid_digit(num: Char) -> Bool{
  return num >= '0' && num <= '9'
}

fn is_valid_letter(letter: Char) -> Bool{
  return (letter >= 'a' && letter <= 'z') || (letter >= 'A' && letter <= 'Z')
}

fn is_valid_symbol(symbol: Char) -> Bool{
  return symbol == ksymbol_neg || symbol == ksymbol_pos || symbol == ksymbol_dot
}

fn is_valid_char(char: Char) -> Bool {
  return is_valid_digit(char) || is_valid_letter(char) || is_valid_symbol(char) 
}


fn split_semver(semver: String) -> SegmentedSemVer? {
  let pos_index = semver.index_of(ksymbol_pos.to_string());  
  let neg_index = semver.index_of(ksymbol_neg.to_string());  

  let container : SegmentedSemVer = SegmentedSemVer::{ core_version:None, pre_release: None, build: None}
  
  if neg_index != -1 {  
      container.core_version = Some(semver.substring(start = 0, end = neg_index))
  } else if pos_index != -1 {
      container.core_version = Some(semver.substring(start = 0, end = pos_index))
  } else {
      container.core_version = Some(semver)
  }

  if neg_index != -1 {  
      let pre_end = if pos_index != -1 { pos_index } else { semver.length() };  
      let str_pre_release = semver.substring(start = neg_index + 1, end = pre_end);  
      if str_pre_release.length() > 0 {  
          container.pre_release = Some(str_pre_release)
      } else {  
          return None;
      }  
  }  

  if pos_index != -1 {  
      let str_build = semver.substring(start = pos_index + 1);  
      if str_build.length() > 0 {  
          container.build = Some(str_build);  
      } else {  
          return None;
      }  
  }  

  return Some(container)
}