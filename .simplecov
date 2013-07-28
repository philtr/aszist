SimpleCov.start 'rails' do
  add_filter 'vendor'
  add_filter 'helpers'
  add_filter 'lib/tasks'

  # add_group 'Services', 'app/services'
  # add_group 'Interfaces', 'app/interfaces'
  # add_group 'Validators', 'app/validators'
end
