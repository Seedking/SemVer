# 🌽SemVer

## 🚀 Key Feature
* Parse SemVer string to struct
* Compare SemVer struct

---

## Parse

```moonbit
fn main {
    let v1 = @SemVer.parse("1.0.0")
}
```

---

## Compare

```moonbit
fn main {
    let v1 = @SemVer.parse("1.0.0")
    let v2 = @SemVer.parse("2.0.0")
    if v1 < v2 { println("v1 is smaller!") }
}
```