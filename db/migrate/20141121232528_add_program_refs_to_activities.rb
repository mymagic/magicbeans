class AddProgramRefsToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :program, index: true
  end
end
