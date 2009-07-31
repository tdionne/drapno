# == Schema Information
#
# Table name: dreamers
#
#  id                 :integer(4)      not null, primary key
#  email              :string(255)
#  encrypted_password :string(128)
#  salt               :string(128)
#  token              :string(128)
#  token_expires_at   :datetime
#  email_confirmed    :boolean(1)      not null
#  last_signed_in_at  :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string(128)
#  location           :string(255)
#  gender             :string(10)
#  age_band           :string(8)
#  ratings_count      :integer(4)      default(0), not null
#  public_profile     :boolean(1)      default(TRUE)
#  role               :string(255)     default("user"), not null
#  public_alias       :string(63)
#

require 'dreamer'
User = Dreamer
