module InvitationsHelper                                                       
  #                                                                            
  # edit_user_invitation GET    /users/:user_id/invitations/:id/edit           
  # 
  def edit_user_invitation_path_secure(user,invitation)                                    
    "/users/#{user.id}/invitations/#{invitation.permalink}/edit"               
  end       
  #                                                                    
  # user_invitation GET    /users/:user_id/invitations/:id                      
  # 
  def user_invitation_path_secure(user,invitation)                                         
    "/users/#{user.id}/invitations/#{invitation.permalink}"                    
  end                                                                          
                                                                               
end                                                                            
                                                                               