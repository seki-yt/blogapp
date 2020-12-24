# module 名前を一致させること
# viewで使えるメゾットはHelperでも使える

module TabsHelper
  def add_active_class(path)
    'active' if current_page?(path)
  end
end