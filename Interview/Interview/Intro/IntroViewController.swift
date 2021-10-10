
import Utils

final class IntroViewController: BaseViewController {

    let presenter: IntroViewPresenter
    private lazy var castedView = IntroView()
    
    init(presenter: IntroViewPresenter) {
        self.presenter = presenter
        
        super.init()
    }
    
    override func loadView() {
        view = castedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        castedView.delegate = self
        title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateNavigationBarVisibility(isHidden: true, animated: animated)
        castedView.updateWebsiteButtonVisibility(isHidden: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateNavigationBarVisibility(isHidden: false, animated: animated)
        castedView.updateWebsiteButtonVisibility(isHidden: true)
    }
    
    private func updateNavigationBarVisibility(isHidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }
}

extension IntroViewController: IntroViewDelegate {
    
    func didTapWebsiteButton() {
        presenter.showOMDBWebsite()
    }
    
    func didTapEnterButton() {
        presenter.showMovieList(on: self)
    }
}
