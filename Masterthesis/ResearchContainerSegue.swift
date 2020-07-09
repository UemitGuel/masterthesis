import UIKit

class ResearchContainerSegue: UIStoryboardSegue {
    
    override func perform() {
        let controllerToReplace = source.children.first
        let destinationControllerView = destination.view
        
        destinationControllerView?.translatesAutoresizingMaskIntoConstraints = true
        destinationControllerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        destinationControllerView?.frame = source.view.bounds
        
        controllerToReplace?.willMove(toParent: nil)
        source.addChild(destination)
        
        source.view.addSubview(destinationControllerView!)
        controllerToReplace?.view.removeFromSuperview()
        
        destination.didMove(toParent: source)
        controllerToReplace?.removeFromParent()
    }
}
