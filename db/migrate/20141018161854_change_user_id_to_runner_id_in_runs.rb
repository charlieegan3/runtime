class ChangeUserIdToRunnerIdInRuns < ActiveRecord::Migration
  def change
  	rename_column :runs, :user_id, :runner_id
  end
end
