module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the homepage/i
      root_path
    when /the sign up page/i
      sign_up_path
    when /the sign in page/i
      new_session_path
    when /the sign out page/i
      sign_out_path
    when /the password reset request page/i
      new_password_path
    when /new invitation page/i
      new_invitation_path
    when /the dream page for "(.+?)"/i
      d = Dream.find_by_title($1)
      dream_path(d)
    when /the dreamer page for "(.+?)"/i
      d = Dreamer.find_by_email($1)
      dreamer_path(d)
    when /the edit profile page for "(.+?)"/i
      d = Dreamer.find_by_email($1)
      edit_dreamer_path(d)
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end
 
World(NavigationHelpers)
