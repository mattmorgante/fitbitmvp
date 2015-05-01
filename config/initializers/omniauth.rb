Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, '978d0a72a55a709a67e26868770d6131', '0537b84f3605af1716d4790bcf6d0bc7'
end