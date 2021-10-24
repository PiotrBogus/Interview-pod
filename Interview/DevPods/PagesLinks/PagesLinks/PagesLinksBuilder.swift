
import Foundation

public final class PagesLinksBuilder {
    
    public init() {}
    
    public func build() -> PagesLinksProviding {
        PagesLinksProvider(linksSet: InterviewPagesLinksSet())
    }
}
