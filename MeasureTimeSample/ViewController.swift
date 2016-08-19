import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var startTime: NSDate?
    
    @IBOutlet weak var startLapLabel: UILabel!
    @IBOutlet weak var endLapLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func start(sender: UITapGestureRecognizer) {
        startTime = NSDate()
        startLapLabel.text = ViewController.dateFormatter.stringFromDate(startTime!)
        
        endLapLabel.text = "タップして終了"
        timeLabel.text = "計測中…"
    }

    @IBAction func end(sender: UITapGestureRecognizer) {
        let endTime = NSDate()
        
        let calendar: NSCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        // 取得する情報の種類を指定し、2つの日時の間の差分を取得
        let unit: NSCalendarUnit = [ .Hour, .Minute, .Second, .Nanosecond ]
        let elapsedTime: NSDateComponents = calendar.components(unit, fromDate: startTime!, toDate: endTime, options: NSCalendarOptions())
        
        endLapLabel.text = ViewController.dateFormatter.stringFromDate(endTime)
        
        // 日時の各部分を分割して取得して書式を設定し、ラベルに表示
        // ミリ秒の部分は上2桁のみ表示（標準の時計アプリを参考）したいので、ナノ秒からの変換は1_000_000ではなく10_000_000で割っている
        timeLabel.text = String(format: "%02d時間%02d分%02d秒%.0f",
                                elapsedTime.hour, elapsedTime.minute, elapsedTime.second, Double(elapsedTime.nanosecond) / 10_000_000)
    }
    
    static var dateFormatter: NSDateFormatter {
        // 書式とロケールを指定した日時のフォーマッターを準備
        // calendarにグレゴリオ暦を指定しているのは、デバイスの設定で和暦などを選択した場合の不具合を防ぐため
        let formatter = NSDateFormatter()
        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "HH時mm分ss秒SS"
        return formatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

