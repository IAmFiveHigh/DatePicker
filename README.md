# DatePicker
-因为iOS自带datePicker不支持两个component展示年月 写了个能只展示年月功能的pickerView


## 安装
-直接把LHCDatePicker.swift文件拖进工程

## 使用
init方法创建 可以设置起始日期参数
``` swift
let a = LHCDatepicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), 起始时间: "2018-3-20")
```
因为自带背景shadow 所以设置大小建议为屏幕宽高

设置显示格式
```swift
a.dateType = .年月
```

显示格式三种
```swift
    enum 日期格式 {
        case 年月日
        case 年月
        case 年
    }
```


### 带设置起始日期和最晚日期功能
-设置最早日期
```swift
        let time = "2018-4-15"
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-M-dd"
        a.minDate = formate.date(from: time)!
```
-设置最晚日期
```swift
        let time = "2018-5-10"
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-M-dd"
        a.maxDate = formate.date(from: time)!
```
