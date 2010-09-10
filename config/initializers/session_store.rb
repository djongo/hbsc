# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hbsc_session',
  :secret      => '8ba5f00f69cc255f0f846340fb0c8c048d531fb1f24ecee048284a070dd1fc17d52a1ffd778bec1ccf531d74b63a00e596b0695c678a009224a9c7164917a462'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
