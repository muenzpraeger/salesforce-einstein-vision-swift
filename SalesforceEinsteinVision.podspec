

Pod::Spec.new do |s|
  s.name             = 'SalesforceEinsteinVision'
  s.version          = '1.3.4'
  s.summary          = 'Swift wrapper for Salesforce Einstein Vision'

  s.description      = <<-DESC
This library is a wrapper for the Salesforce Einstein Vision API
                       DESC

  s.homepage         = 'https://github.com/muenzpraeger/salesforce-einstein-vision-swift'
  s.license          = { :type => 'APACHE-2.0', :file => 'LICENSE.md' }
  s.author           = { 'René Winkelmeyer' => 'git@winkelmeyer.com' }
  s.source           = { :git => 'https://github.com/muenzpraeger/salesforce-einstein-vision-swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muenzpraeger'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SalesforceEinsteinVision/Classes/**/*'
  
  s.dependency 'Alamofire', '~> 4.0'
  s.dependency 'SwiftyJSON'
end
