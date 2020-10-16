class AddUsersToApplications < ActiveRecord::Migration[5.2]
  def change
    add_reference :applications, :user, foreign_key: true
  end
end
