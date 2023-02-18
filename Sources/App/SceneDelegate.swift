import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Properties
    
    var window: UIWindow?
    let rootVCBuilder = UIBuilderRootViewController()
    let sharedService = SharedServices()

    //MARK: - Application lifecycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = rootVCBuilder.buildRootViewController(cacheService: sharedService.cacheService)
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        sharedService.cacheService.saveContext()
    }
}
