Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '750901265022718', '6fc803c94f4d22e97d798ffb030aed31'
end