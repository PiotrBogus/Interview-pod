
public enum ElementIdentifiers {

    public enum Intro {
        
        public static let view = UIElementIdentifier(id: "intro_view", type: .other)
        public static let enterButton = UIElementIdentifier(id: "intro_continue_button", type: .button)
        public static let websiteButton = UIElementIdentifier(id: "intro_website_button", type: .button)
    }
    
    public enum Generic {
        
        public static let toastNotification = UIElementIdentifier(id: "generic_toast_notification", type: .other)
    }
    
    public enum TabBar {
        
    }
    
    public enum MovieList {
        
        public static let view = UIElementIdentifier(id: "movie_list_view", type: .other)
        public static let searchBar = UIElementIdentifier(id: "movie_list_search_bar", type: .other)
        public static func cell(index: Int) -> UIElementIdentifier {
            UIElementIdentifier(id: "movie_list_cell_\(index)", type: .cell)
        }
    }
}
