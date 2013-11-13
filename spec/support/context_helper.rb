module ContextHelper

  private

  def reset_user_id
    set_user_id(nil)
  end

  def set_user_id(user_id)
    $user_id = {}
    $user_id[Thread.current] = user_id
  end

  def reset_session_id
    set_session_id(nil)
  end

  def set_session_id(session_id)
    $session_id = {}
    $session_id[Thread.current] = session_id
  end

end