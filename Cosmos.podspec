Pod::Spec.new do |s|
  s.name        = "Cosmos"
  s.version     = "12.0.1"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/evgenyneu/Cosmos"
  s.summary     = "5-star rating control written in Swift"
  s.description  = <<-DESC
                   This is a UI control for iOS and tvOS that shows a 5-star rating or takes rating input from the user. Cosmos is a subclass of a UIView. Let your users see and post beautiful 3-star reviews!

                   * Shows star rating with an optional text label.
                   * Can be used as a rating input control (iOS only).
                   * Cosmos view can be customized in the Storyboard without writing code.
                   * Includes different star filling modes: full, half-filled and precise.
                   * Cosmos is accessible and works with voice-over.
                   * Supports right-to-left languages.
                   DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/evgenyneu/Cosmos.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/evgenyneu/Cosmos/master/graphics/Screenshots/cosmos_star_rating_control_for_ios_swift_space.png"
  s.source_files = "Cosmos/**/*.swift"
  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
end