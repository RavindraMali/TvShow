class JobEmailMailer < ApplicationMailer

    def job(counter)
        @counter = counter
        email(to: current_user.email, subject: "Job Email")
    end

end
