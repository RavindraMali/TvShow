class ShowNotificationMailer < ApplicationMailer

    def notification
        @show = Show.find(params[:show_id])
        @user = User.find(params[:user_id])
        mail(to: @user.email, subject: 'Show reminder')
    end
end
