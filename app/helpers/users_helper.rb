module UsersHelper
  # change str to screen_name format ("Screen Name" -> "Screen_Name")
  def self.screen_name_formatter(str)
    str.gsub(/ /, '_')
  end

  # urlだけ返す 設定なしならデフォルト
  def icon_url(user = current_user)
    if !user || user.icon.url.blank?
      asset_path('icon_default')
    else
      user.icon.url
    end
  end

  # さらにicon_urlをimageタグを返してくれる
  def icon_for(user, size: 80, htmlclass: 'usericon')
    image_tag(icon_url(user), alt: user.handle_name, size: size.to_s, class: htmlclass, id: "usericon-#{user.id}")
  end

  def current_user?(user)
    user == current_user
  end

  def friend?(user)
    user == current_user || (user.followee?(current_user) && user.follower?(current_user))
  end

  # 「自分がログイン済みで、かつ相手が自分以外のユーザーかどうか」
  def other_user?(user)
    !!current_user && current_user != user
  end

  def followee_or_self?(user)
    current_user == user || current_user.followee?(user)
  end

  # 1つめの返り値は日にちごとのヌイートが入ったハッシュ、2つめは開始日
  def contribution_for(user, row)
    # カレンダーの内訳: (row - 1)行分の完全な週 + 日曜〜今日まで
    start_day = Date.current.beginning_of_week(:sunday) - (row - 1).week
    nweets = user.nweets.where(:created_at=> start_day..Time.current)

    hash = calendarize_data(nweets, column: :did_at)

    return hash, start_day
  end
end
