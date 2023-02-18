import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Properties
    
    var window: UIWindow?
    let rootVC = UIBuilderRootViewController()

    //MARK: - Application lifecycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = rootVC.buildRootViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        rootVC.cacheService.saveContext()
    }
}
