Pod::Spec.new do |s|
  s.name         = "ELCTextFieldCell"
  s.version      = "0.0.1"
  s.summary      = "UITableViewCell subclass to help with form creation."
  s.homepage     = "http://www.icodeblog.com/2011/01/04/elctextfieldcell-a-useful-tableviewcell-for-forms/"
  s.license      = { :type => 'MIT', :file => 'README' }
  s.author       = { "Collin Ruffenach" => "cruffenach@gmail.com" }
  s.source       = { :git => "https://github.com/elc/ELCTextFieldCell.git", :commit => "5c043ea" }
  s.platform     = :ios
  s.source_files = 'Classes/ELCTextfieldCell.{h,m}'
end

