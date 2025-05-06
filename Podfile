# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Movia' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
#use_frameworks! :linkage => :static

#  pod 'IJKMediaFramework'                           # IJK播放器
  pod 'SnapKit'                                     # swift 布局
  pod 'Moya/RxSwift'                                # 网络请求 + 信号
  pod 'HandyJSON'                                   # 解析
  pod 'RxCocoa'                                     #
  pod 'Kingfisher'                                  # 网络图片加载
  pod 'JXPagingView/Paging'                         # 分页
  pod 'EllipsePageControl'                          # 分页控制器
  pod 'JXSegmentedView'                             # 选择器 配合 分页 使用
  pod 'HWPanModal'                                  # 模态底部弹出控制器
  pod 'YYText'                                      # 富文本
  pod 'KeychainSwift'                               # 钥匙链
  pod 'SAMKeychain'                                 # KeyChain
  pod 'ProgressHUD'                                 # loading
  pod 'MBProgressHUD'                               # loading
  pod 'ZVProgressHUD'                               # loading
  pod 'FlyHUD'                                      # loading
  pod 'IGListKit'                                   # 列表
  pod 'MJRefresh'                                   # 下拉刷新
  pod 'FSPagerView'                                 # 轮播
  pod 'GKCycleScrollView'                           # 轮播图控件
  pod 'WaterfallLayout'                             # 瀑布流
  pod 'EachNavigationBar'                           # 导航栏
  pod 'TikTokOpenSDKCore'                           # TikTok 登录
  pod 'TikTokOpenAuthSDK'                           # TikTok 验证
  pod 'TikTokOpenShareSDK'                          # TikTok 分享
  pod 'FBSDKLoginKit'                               # Facebook 登录
  pod 'FBSDKShareKit'                               # Facebook 分享
  pod 'GoogleSignIn'                                # Google 登录
  pod 'DZNEmptyDataSet'                             # 空列表
  pod 'SwiftyStoreKit'                              # 内购
  pod 'Toast'                                       # 吐司提示
  pod 'YYStarView'                                  # 评价星
  pod 'TZImagePickerController'                     # 相册
  pod 'RKNotificationHub'                           # badge
  pod 'Adjust'                                      # Adjust 归因
  
  pod 'AppLovinSDK'                                 # AppLovin
  pod 'AppLovinMediationFacebookAdapter'            # applovin Facebook 中介
  pod 'AppLovinMediationByteDanceAdapter'           # applovin Pangle 中介
#  pod 'AppLovinMediationGoogleAdManagerAdapter'     # applovin Google 中介
  pod 'AppLovinMediationIronSourceAdapter'          # applovin IronSource 中介
  pod 'AppLovinMediationMintegralAdapter'           # applovin Mintegral 中介

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
    
#    installer.pods_project.build_configurations.each do |config|
#      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#    end

  end
end
