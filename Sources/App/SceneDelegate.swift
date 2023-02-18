import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Properties
    
    var window: UIWindow?
    let rootVCBuilder = UIBuilderRootViewController()
    let sharedServices = SharedServices()

    //MARK: - Application lifecycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = rootVCBuilder.buildRootViewController(cacheService: sharedServices.cacheService)
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        sharedServices.cacheService.saveContext()
    }
}
