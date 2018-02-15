class Users::OmniauthCallbacksController < ApplicationController
  def twitter
    puts 'omniauth.auth', request.env['omniauth.auth']['credentials']
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session['devise.user_attributes'] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
end
# https://qiita.com/okamos/items/ecb5d45d6875696dbbed
# omniauth.auth from twitter
# {
#    "provider"   =>"twitter",
#    "uid"   =>"0123456789",
#    "info"   =>   {
#       "nickname"      =>"manycicadas",
#       "name"      =>"芭蕉",
#       "location"      =>"関東",
#       "image"      =>"http://pbs.twimg.com/profile_images/483964583371997185/2ZqzhzKV_normal.png",
#       "description"      =>"JavaEE/Ruby(Rails)/HTML/CSS/JavaScript/Raspberry Pi などなどが好き。",
#       "urls"      =>      {
#          "Website"         =>nil,
#          "Twitter"         =>"https://twitter.com/manycicadas"
#       }
#    },
#    "credentials"   =>   {
#       "token"      =>"0123456789-hQywfs78sQ9NnwpSkwiejf2Ij74sut7hKjEsF9",
#       "secret"      =>"sijIYUsiJslOhiwkYukshKKJG6skWbhbXCYji3sabla3O1"
#    }
# }

# https://myaccount.google.com/lesssecureapps?pli=1 -> on
# https://support.google.com/accounts/answer/6010255
# https://support.google.com/accounts/answer/185839