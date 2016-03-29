# CategoryView
Reusable CategoryView in swift. It will take less than 5 min to integrate it with your app.

![demo01](https://raw.githubusercontent.com/VictorKid/gigCategories/master/GigCategoires-Demo.gif)

# Usage
```swift
class ViewController: UIViewController {
    
    var gigMainCategoriesVC = GigMainCategoriesVC()
    var categoryItems = [CategoryItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryItems = [
            CategoryItem(title: "傢俱", icon: UIImage(named: "double_bed")!),
            CategoryItem(title: "影音", icon: UIImage(named: "films")!),
            CategoryItem(title: "科技", icon: UIImage(named: "mac")!),
            CategoryItem(title: "文藝", icon: UIImage(named: "music_note")!),
            CategoryItem(title: "理財", icon: UIImage(named: "note_dollar")!),
            CategoryItem(title: "文具", icon: UIImage(named: "ruler_pencil")!),
            CategoryItem(title: "體育", icon: UIImage(named: "soccer_ball")!),
            CategoryItem(title: "戶外", icon: UIImage(named: "surfer")!),
            CategoryItem(title: "休閒", icon: UIImage(named: "tea_cup")!),
        ]
        
        gigMainCategoriesVC.categoryItems = categoryItems
        gigMainCategoriesVC.dataSource = self
        gigMainCategoriesVC.delegate = self
        
        view.addSubview(gigMainCategoriesVC.view)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("GigMainVC viewWillAppear")
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
}
```

```swift
// MARK: - Implemention of Delegate and DataSource method
extension ViewController: GigMainCategoriesViewDataSource {
    func numberOfCategoryViews() -> Int {
        return categoryItems.count
    }
    
    func renderCategoryCotent(contentForRowAtIndexPath indexPath: NSIndexPath) -> UIView {
        let content = UIView(frame: CGRect(x: 0, y: 0, width: maxWidth, height: maxHeight))
        let index = indexPath.row
        if index % 2 == 0 {
            content.backgroundColor = UIColor.redColor()
        } else {
            content.backgroundColor = UIColor.greenColor()
        }
        return content
    }
    
}

extension ViewController: GigMainCategoriesViewDelegate {
    func categoryView(categoryView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        categoryView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func categoryView(categoryView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250.0
    }
}
```

# Todos
- More detailed docs
- Publish to cocoadpods
