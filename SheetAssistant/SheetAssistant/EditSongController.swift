import UIKit

class EditSongController: UIViewController {
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editArtist: UITextField!
    @IBOutlet weak var editTabs: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editTitle.text = currentLyrics
        editArtist.text = currentArtist
        editTabs.text = currentLyrics

    }


}
