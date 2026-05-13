module ApplicationHelper
  # タイトル表示用のメソッド
  def page_title(title = "")
    base_title = "HealScan"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
