# app/admin/dashboard.rb

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Example content (opcional):
    section "Recent Admin Users" do
      table_for AdminUser.order("created_at desc").limit(5) do
        column :email
        column :created_at
      end
    end
  end
end
