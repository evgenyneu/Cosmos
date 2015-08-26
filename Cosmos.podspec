Pod::Spec.new do |s|
  s.name        = "Cosmos"
  s.version     = "1.0.15"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/exchangegroup/Cosmos"
  s.summary     = "5-star rating control written in Swift"
  s.description  = <<-DESC
                   This is a UI control for iOS that shows a 5-star rating or takes rating input from the user. Cosmos is a subclass of a UIView. Let your users see and post beautiful 3-star reviews!

                   * Shows star rating with an optional text label.
                   * Can be used as a rating input control.
                   * Cosmos view can be customized in the Storyboard without writing code.
                   * Includes different star filling modes: full, half-filled and precise.
                   DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/exchangegroup/Cosmos.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/exchangegroup/Cosmos/master/graphics/Screenshots/star_screenshot_dark.png"
  s.source_files = "Cosmos/**/*.swift"
  s.ios.deployment_target = "8.0"

  s.subspec 'Distrib' do |ss|
    ss.source_files = 'Distrib/CosmosDistrib.swift'
  end
end