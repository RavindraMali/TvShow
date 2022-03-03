class ShowNotificationMailer < ApplicationMailer

    def notification(show, user)
        @show = show
        @user = user
        mail(to: @user.email, subject: 'Show reminder')
    end
end
