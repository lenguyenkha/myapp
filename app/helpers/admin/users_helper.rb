module Admin
  module UsersHelper
    def gender user
      if user.gender == true
        content_tag :td, t(".male")
      elsif user.gender == false
        content_tag :td, t(".female")
      elsif user.gender.nil?
        content_tag :td, t(".none")
      end
    end

    def activated user
      if user.activated == true
        content_tag :td do
          content_tag :i, "", class: "fa fa-check"
        end
      elsif user.activated == false
        content_tag :td do
          content_tag :i, "", class: "fa fa-times"
        end
      end
    end
  end
end
